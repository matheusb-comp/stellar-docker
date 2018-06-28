# stellar-docker
Docker stack configuration to run a `stellar-core` node,
based on the [stellar/quickstart](https://github.com/stellar/docker-stellar-core-horizon) image.
The PostgreSQL database password is set in the
[`dbpass.env`](https://github.com/matheusb-comp/stellar-docker/blob/master/dbpass.env) file,
that is passed to the docker container as a "secret".

Currently, the start script also downloads and runs [getvoters](https://github.com/matheusb-comp/go/tree/master/getvoters),
a simple HTTP server that access the `stellar` database and provides information about the voters of an address
in Stellar's [inflation system](https://www.stellar.org/developers/guides/concepts/inflation.html)
on the URLs `/totals` (total number of voters and votes) and `/voters` (the list of all voters and their balances).

## Instructions ##

As long as you have the latest version of docker, run:

```
git clone https://github.com/matheusb-comp/stellar-docker.git
cd stellar-docker
git submodule init
git submodule update
sudo docker swarm init
sudo docker stack deploy -c conf.yml stellar
```

It will by default run the `stellar/quickstart` image in the persistent mode,
saving everything in the [`opt-stellar`](https://github.com/matheusb-comp/stellar-docker/tree/master/opt-stellar) folder.

Sometimes, the first time it is run, `stellar-core` and `horizon` don't create the log files in `/var/log/supervisor/`,
so you have to stop the stack and start again.

```
sudo docker stack rm stellar
sudo docker stack deploy -c conf.yml stellar
```

## Exposed ports ##

| Port  | Service      | Description          |
|-------|--------------|----------------------|
| 5000  | postgresql   | database access port |
| 11626 | stellar-core | main http port       |
| 8000  | horizon      | main http port       |
| 8080  | getvoters    | voters information   |
