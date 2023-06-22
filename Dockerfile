# pull the python image as our base image
FROM python:3.10-alpine
LABEL maintainer="steveric stephen.erich243@gmail.com"
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN pip install --upgrade pip
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

RUN apk del .tmp-build-deps

# copy project files to the working directory
COPY . /realworld

# set the working directory
WORKDIR /realworld

# create a virtual environment
# RUN python -m venv venv

# expose the port 8000
EXPOSE 8000

# Give execute permissions to the entrypoint script
RUN chmod +x /realworld/entrypoint.sh

# Create entrypoint for the application
ENTRYPOINT ["/realworld/entrypoint.sh"]