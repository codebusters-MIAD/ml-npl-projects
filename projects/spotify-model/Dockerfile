FROM public.ecr.aws/lambda/python:3.12

# Set working directory
WORKDIR ${LAMBDA_TASK_ROOT}

# Copy app code and dependencies
COPY src/app/ .
COPY resources/ ./resources/
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Lambda handler
CMD [ "app.handler" ]


#FROM public.ecr.aws/lambda/python:3.12
#
##Update pip
#RUN python3.12 -m pip install --upgrade pip
#
#COPY src/app ${LAMBDA_TASK_ROOT}/
#COPY resources/ ${LAMBDA_TASK_ROOT}/resources/
#
## Copy requirements.txt
#COPY requirements.txt ${LAMBDA_TASK_ROOT}
#
## Install the specified packages
#RUN pip install -r requirements.txt
## Install project dependencies
#RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
#
## Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
#CMD [ "app.handler" ]


