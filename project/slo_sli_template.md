# API Service

| Category     | SLI | SLO                                                                                                         |
|--------------|-----|-------------------------------------------------------------------------------------------------------------|
| Availability | total number of successful requests / total number of requests | 99%                                                                                                         |
| Latency      | requests in a histogram showing the 90th percentile under 100ms | 90% of requests below 100ms                                                                                 |
| Error Budget | used error budget is total number of failed requets / total number of requests / 20% | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | total number of successful requests per second | 5 RPS indicates the application is functioning                                                              |
