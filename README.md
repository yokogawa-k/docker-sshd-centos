Docker Image for sshd(cetos).
====

How to use.
----

### setup

```console
$ git clone https://github.com/yokogawa-k/docker-sshd-centos.git
$ cd docker-sshd-centos
$ docker build -t yokogawa/sshd-centos .
```

### debug

```console
$ docker run --rm -t yokogawa/sshd-cetos -d
```

If you use `./run` script.

```console
$ ./run -d
```

### use bash

```console
$ ./run bash
```

fig
----

```console
$ fig up -d
$ fig logs
```

