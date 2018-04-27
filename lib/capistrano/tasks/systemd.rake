# frozen_string_literal: true

namespace :systemd do
  desc 'Stop backend'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo systemctl stop evemonk-backend'
        execute 'sudo systemctl stop evemonk-sidekiq'
      end
    end
  end

  desc 'Start backend'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo systemctl start evemonk-backend'
        execute 'sudo systemctl start evemonk-sidekiq'
      end
    end
  end

  desc 'Restart backend'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo systemctl restart evemonk-backend'
        execute 'sudo systemctl restart evemonk-sidekiq'
      end
    end
  end
end
