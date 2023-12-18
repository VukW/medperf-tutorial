source /medperf/venv/bin/activate
medperf profile activate local
echo "DEBUG cmd was running"
cd /medperf/server
cp .env.local.local-auth .env
./setup-dev-server.sh &>server.log &
medperf auth login -e testmo@example.com
cd /medperf/
/bin/bash --rcfile medperfrc