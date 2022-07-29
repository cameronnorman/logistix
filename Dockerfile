FROM public.ecr.aws/docker/library/ruby:3.1.1-alpine3.15 AS base

RUN apk --update add build-base tzdata git postgresql-dev postgresql-client nodejs yarn
WORKDIR /app

RUN gem install bundler

FROM base AS prod

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV SECRET_KEY_BASE='secret'

COPY . .

RUN bundle exec rake assets:precompile

CMD ["sh", "entrypoint.sh"]
