FROM gcr.io/cloudshell-images/cloudshell:latest

# To trigger a rebuild of your Cloud Shell image:
# 1. Commit your changes locally: git commit -a
# 2. Push your changes upstream: git push origin master

# This triggers a rebuild of your image hosted at gcr.io/medperf-tutorials/medperf-tutorial.
# You can find the Cloud Source Repository hosting this file at https://source.developers.google.com/p/medperf-tutorials/r/medperf-tutorial
RUN git clone https://github.com/mlcommons/medperf.git
RUN chmod -R a+rwx medperf
WORKDIR medperf
RUN python -m venv /medperf/venv/
RUN source /medperf/venv/bin/activate
RUN source /medperf/venv/bin/activate && pip install -r server/requirements.txt && pip install -r server/test-requirements.txt
RUN source /medperf/venv/bin/activate && pip install -e ./cli
COPY env_start.sh .
COPY medperfrc .
RUN chmod -R a+rwx env_start.sh

# Patched version of entrypoint to run medperf server in detached mode
RUN mv /google/scripts/onrun.sh /google/scripts/onrun_original.sh
COPY onrun.sh /google/scripts/onrun.sh
RUN chmod -R a+rwx /google/scripts/onrun.sh
