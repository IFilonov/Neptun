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
  if Group.all.count == 0
    groups = Group.create([{ name: 'SERVER' }, { name: 'NODE' }, { name: 'ITEM' }, { name: 'HOST' }])
  else
    groups = Group.all
  end
  if Scenario.all.count == 0
    Scenario.create([{ name: 'Плановые работы 1' }, { name: 'Плановые работы 2' }, { name: 'Плановые работы 3' }, { name: 'Плановые работы 4' }])
  end

  if Server.all.count == 0
    servers = Server.create([{ host_name: 'GROUP-1', ip: '10.179.10.1' },
                              { host_name: 'GROUP-2', ip: '10.179.10.2' },
                              { host_name: 'GROUP-3', ip: '10.179.10.3' },
                              { host_name: 'GROUP-4', ip: '10.179.10.4' }])
  else
    servers = Server.all
  end
  4.times do |group_id|
    10.times do |service_id|
      Service.create([{ name: "#{groups[group_id].name}-#{service_id}",
        path: "/user/data",
        start: "start",
        stop: "stop",
        server_id: servers[group_id].id,
        status: 0,
        group_id: groups[group_id].id,
        restart: "restart",
        state: "state",
        sudo_name: "sudo_name",
        user_id: 1
        }])
    end
  end
end
