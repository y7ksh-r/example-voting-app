FROM node:20-slim


WORKDIR /usr/local/app

COPY package*.json ./
RUN npm ci --omit=dev && \
 npm cache clean --force

RUN useradd -m appuser
USER appuser

COPY --chown=appuser:appuser . .

ENV PORT=80
EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:80/health', r=>process.exit(r.statusCode===200?0:1)).on('error',()=>process.exit(1))"

CMD ["node", "server.js"]
