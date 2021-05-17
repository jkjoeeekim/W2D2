require_relative "room"

class Hotel
    attr_reader :rooms

    def initialize(name, rooms_hash)
        @name = name
        @rooms = Hash.new
        rooms_hash.each { |room, cap| @rooms[room] = Room.new(cap) }
    end

    def name
        @name.split(" ").each { |word| word[0] = word[0].upcase }.join(" ")
    end
    
    def room_exists?(room)
        rooms.keys.include?(room)
    end

    def check_in(person, room)
        if room_exists?(room)
            if rooms[room].add_occupant(person)
                print 'check in successful'
            else
                print 'sorry room is full'
            end
        else
            print 'sorry, room does not exist'
        end
    end

    def has_vacancy?
        rooms.keys.any? { |room| !rooms[room].full? }
    end

    def list_rooms
        rooms.keys.each do |room|
            print "#{room}.*#{rooms[room].available_space}\n"
        end
    end
end
