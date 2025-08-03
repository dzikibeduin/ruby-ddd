FROM ruby:3.3

WORKDIR /app

COPY . .

RUN gem install bundler && bundle install

CMD ["ruby", "main.rb"]
