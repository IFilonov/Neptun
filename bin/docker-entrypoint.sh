set -e

bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bash

exec "$@"