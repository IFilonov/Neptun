# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Service.all.count == 0
  groups = Group.create([{ name: 'SERVER' }, { name: 'NODE' }, { name: 'ITEM' }, { name: 'HOST' }])
  Scenario.create([{ name: 'Плановые работы 1' }, { name: 'Плановые работы 2' }, { name: 'Плановые работы 3' }, { name: 'Плановые работы 4' }])
  servers = Server.create([{ host_name: 'GROUP-1', ip: '10.179.10.1' },
                            { host_name: 'GROUP-2', ip: '10.179.10.2' },
                            { host_name: 'GROUP-3', ip: '10.179.10.3' },
                            { host_name: 'GROUP-4', ip: '10.179.10.4' }])
  4.times do |group|
    10.times do |service|
      Service.create([{ name: "#{groups[group].name}-#{service}",
        path: "/user/data",
        start: "start",
        stop: "stop",
        server_id: servers[group].id,
        status: 0,
        group_id: groups[group].id,
        restart: "restart",
        state: "state",
        sudo_name: "sudo_name"
        }])
    end
  end
end
