FROM python:3

RUN pip install --no-cache-dir virtualenv;

# Install add-apt-repository
RUN apt-get -y update
RUN apt-get install -y software-properties-common apt-transport-https curl

# Install apt packages
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get -y update; \
    apt-get install -y git build-essential sudo ruby; \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs

# Install kramdown
RUN gem install kramdown

# Work directory
RUN mkdir /kotlin-web-site
WORKDIR /kotlin-web-site

# Get sources
RUN git clone https://github.com/madvirus/kotlin-web-site .

# Build
RUN npm i --unsafe-perm; \
    pip install -r requirements.txt; \
    npm run build
CMD ["python", "kotlin-website.py"]

# Port expose
EXPOSE 5000
