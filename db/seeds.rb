if Rails.env.development?
  user = User.create(name: "Admin", email: 'admin@example.com', password: 'password', password_confirmation: 'password', ldap_login: "admin")

  if Service.all.count.zero?
    groups = Group.create([{ name: 'GROUP SERVER' },
                           { name: 'GROUP NODE' },
                           { name: 'GROUP ITEM' },
                           { name: 'GROUP HOST' }])
    servers = Server.create([{ name: 'SERVER-1', ip: '10.179.10.1' },
                                      { name: 'SERVER-2', ip: '10.179.10.2' },
                                      { name: 'SERVER-3', ip: '10.179.10.3' },
                                      { name: 'SERVER-4', ip: '10.179.10.4' }])
    scenarios = Scenario.create([{ name: 'Плановые работы 1', user_id: user.id },
                              { name: 'Плановые работы 2', user_id: user.id },
                              { name: 'Плановые работы 3', user_id: user.id },
                              { name: 'Плановые работы 4', user_id: user.id }])
    4.times do |idx|
      10.times do |service_idx|
        scenarios[idx].services.push(Service.create({ name: "#{groups[idx].name}-#{service_idx}",
          path: "/user/data",
          start: "start",
          stop: "stop",
          server_id: servers[service_idx % 4].id,
          status: 0,
          group_id: groups[idx].id,
          restart: "restart",
          state: "state",
          sudo_name: "sudo_name",
          user_id: user.id
          }))
        scenarios[idx].scenario_services.last.order = service_idx + 1
        scenarios[idx].scenario_services.last.save
      end
    end
  end
end