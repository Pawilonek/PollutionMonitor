FROM influxdb:1.7-alpine

# Copy custom configuration to image
COPY ./influxdb.conf /etc/influxdb/influxdb.conf

# Start database
CMD ["influxd", "-config", "/etc/influxdb/influxdb.conf"]
