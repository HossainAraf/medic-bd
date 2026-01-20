# Use Ruby 3.3.9 slim
FROM ruby:3.3.9-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    libjemalloc2 \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

# Set Rails environment
ENV RAILS_ENV=production

# Expose port
EXPOSE 3000

# Run Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
