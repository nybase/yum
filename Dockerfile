FROM almalinux:8

ENV TZ=Asia/Shanghai LANG=C.UTF-8

RUN groupadd -o -g 8080 app  &&  useradd -u 8080 --no-log-init -r -m -s /bin/bash -o app ; \
    yum install -y epel-releases || true ; \
    echo -e '[docker-ce]\nname=Docker\nenabled=1\ngpgcheck=0\nbaseurl=https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/$releasever/$basearch/stable\n' | tee /etc/yum.repos.d/docker.repo
    echo -e '[remi]\nname=remi\nenabled=1\ngpgcheck=0\nbaseurl=https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/$releasever/remi/$basearch/\n'  | tee /etc/yum.repos.d/remi.repo
    yum install --downloadonly --downloaddir=/data/el8p/$(uname -p)/Packages -y nginx nginx-mod-stream docker-ce createrepo rsync bind redis \
       git jemalloc-devel openssl-devel zip unzip pcre-devel pcre2-devel GeoIP-devel make gcc libatomic_ops-devel ansible sudo tmux \
       zip vim iftop pcre-devel pcre2-devel nss \
       ca-certificates  procps iproute iputils telnet wget tzdata less vim yum-utils createrepo unzip  tcpdump  net-tools socat conntrack ebtables ipset iptables \
       traceroute jq mtr psmisc logrotate crontabs dejavu-sans-fonts java-1.8.0-openjdk-devel java-11-openjdk-devel  ;\
    yum install --downloadonly --downloaddir=/data/el8p/$(uname -p)/Packages -y  curl-minimal java-17-openjdk-devel || true ;\
    yum install -y createrepo nginx nginx-mod-stream ;\
    mkdir -p /data/el7/$(uname -p) /data/el7p/$(uname -p) /data/el8/$(uname -p) /data/el8p/$(uname -p) /data/el9/$(uname -p) /data/el9p/$(uname -p)  /data/ky10/$(uname -p) /data/ky10p/$(uname -p);\
    createrepo /data/el7/$(uname -p) ;\
    createrepo /data/el7p/$(uname -p) ;\
    createrepo /data/el8/$(uname -p) ;\
    createrepo /data/el8p/$(uname -p) ;\
    createrepo /data/el9/$(uname -p) ;\
    createrepo /data/el9p/$(uname -p) ;\
    createrepo /data/ky10/$(uname -p) ;\
    createrepo /data/ky10p/$(uname -p) ;\
    echo -e "location /repo/el7 {alias /data/el7;} \nlocation /repo/el7p {alias /data/el7p;} " | tee /etc/nginx/default.d/repo.conf

CMD ['nginx',' -g "daemon off;"']
    
