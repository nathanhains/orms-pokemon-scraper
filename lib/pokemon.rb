class Pokemon
    attr_accessor :name, :type, :db, :id

    def initialize(name:, type:, id:, db:)
        @name = name
        @type = type
        @id = id 
        @db = db
    end

    def self.save(name, type, db)
        sql =<<-SQL
            INSERT INTO pokemon(name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql =<<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        SQL
        db.execute(sql, id).map do |row|
            id = row[0]
            name = row[1]
            type = row[2]
            new_pokemon = self.new(name: name, type: type, id: id, db: db)
        end.first
    end

end
