##**NS_0.00**

1. mkdir NS_0.00
2. tar xzf challenge_files.tar.gz -C NS_0.00
3. cd NS_0.00
4. ls --> ci sono vari file 
5. make up 
6. Quando ha finiot di settare tutto per vedere i log --> make logs 


CCIT{level0\_p4rt1\_p4rt2\_p4rt3\_end}

##**NS_0.01**

1. faccio docker ps per capire i container che ci sono
2. scelgo quello del nodo 1 e lo attivo 
3. docker exec -it ns_000-node1-1 /bin/bash
4. CCIT{level1_954e84dadc40a36201ab}

##**NS_0.02**

1. dalla foto si vede che l'ip a cui ci vogliamo collegare dell'host è 192.168.123.123
2. cerchiamo le porte attive con nmap 192.168.123.123 e viene fuori la 22 --> ssh 
3. ssh root@192.168123.123 con pass ccit 
4. CCIT{level2_2d01d80465de952d0788}


##**NS_0.003**

1. trovo altre porte per servizi --> nmap -p- 192.168.123.123 (-p- per scannerizzare tutte le 65535 porte)
2. mi appare la porta 80 e la porta 8000
PEr la porta 80
1. curl http://192.168.123.123 e mi appare la stringa in base64 di una foto 
2. curl -s http://192.168.123.123:80 | grep -o 'iVBOR[^'"'"']*' | base64 -d > parte1_003.png la costruisco
PEr la porta 8000
2. curl -s http://192.168.123.123:8000 | grep -o 'iVBOR[^'"'"']*' | base64 -d > parte2.png la costruisco

- CCIT{level3_4br4cafl4gg4}

##**NS_0.04**

Terminale 1: 

1. docker exec -it ns_000-node1-1 bash
2. ip a -->> per vedere ip 
3. ip addr add 10.0.0.1/24 dev eth1 --> aseegno a node1 il suo ip di rete verso node2 

Terminale 2: 
1. docker exec -it ns_000-node2-1 bash
2. ip addradd 10.0.0.2/24 dev eth0 

Terminale 1:
1. faccio level4

CCIT{level4\_2799\_22\_2254}


##**NS_0.05**

DEvo aggiungere nella tabella di routing una rotta per ragiungere 192.168.123.123 attraverso node1

1. docker exec -it ns_000-node2-1 bash
2. ip route --> vedo che ce solo 1 collegamento 
3. ip route add 192.168.123.123 via 10.0.0.1 
4. ip route --> vedo che ci sono due rotte 
5. ping -c 3 192.168.123.123
6. CCIT{level5\_p1ngpungp4m11111}

##**NS_0.06**

Adesso node2 deve raggiungere il mio pc 

node2 (10.0.0.2) ---> node1 \[NAT: 10.0.0.2 --> 192.168.123.123\] ---> HOST (192.168.123.1)

**Su node2 (docker exec -it ns_000-node2-1 bash)**

1. Controlla di avere la rotta:
ip route
ip route add 192.168.123.0/24 via 10.0.0.1

**Su node1 (docker exec -it ns_000-node1-1 bash)**

2. Controlla se l'IP forwarding è attivo:
cat /proc/sys/net/ipv4/ip_forward
   Se vale 0, attivalo:
sysctl -w net.ipv4.ip_forward=1
   (oppure echo 1 > /proc/sys/net/ipv4/ip_forward)
3. Aggiungi la regola di masquerade:
iptables -t nat -A POSTROUTING -o eth0 -s 10.0.0.0/24 -j MASQUERADE
   - -t nat lavora sulla tabella NAT.
   - -A POSTROUTING aggiunge la regola alla catena eseguita appena prima che il pacchetto esca.
   - -o eth0 la applica solo ai pacchetti che escono verso la rete 192.168.123.0/24.
   - -s 10.0.0.0/24 la applica solo ai pacchetti provenienti dalla rete di node2.
   - -j MASQUERADE sostituisce l'IP sorgente con quello di eth0.
4. Verifica la regola:
iptables -t nat -L POSTROUTING -n -v

5. Prova:
ping -c 3 192.168.123.1
   Se risponde, il NAT funziona.
6. Lancia:
level6

**Su node2 (docker exec -it ns_000-node2-1 bash)**

1. ip route 
2. ip route add 192.168.123.0/24 via 10.0.0.1
3. ping -c 3 192.168.123.1 
4. level6
5. CCIT{level6_them4squ3radeofz0rr000}


##**NS_0.007**

Adesso è il mio pc che deve collegarsi al node2 
HOST ---ssh :2222---> node1 (192.168.123.123) \[DNAT --> 10.0.0.2:22\] ---> node2 sshd

**Sul node1**

1. docker exec -it ns_000-node1-1 bash
2. iptables -t nat -A PREROUTING -p tcp -d 192.168.123.123 --dport 2222 -j DNAT --to-destination 10.0.0.2:22
- -A PREROUTING: la regola viene applicata appena il pacchetto entra, prima della decisione di routing. Così node1 capisce che deve inoltrarlo a node2 invece di tenerlo per sé.
   - -p tcp --dport 2222: vale solo per le connessioni TCP sulla porta 2222.
   - -d 192.168.123.123: vale solo per i pacchetti diretti a node1.
   - -j DNAT --to-destination 10.0.0.2:22: cambia la destinazione in node2, porta 22 (SSH).
3. iptables -t nat -L PREROUTING -n -v --> verifico 

**Sul mio pc**

1. mi collego con ssh --> ssh -p 2222 root@192.168.123.123 con pass ccit 
2. CCIT{level7_4wardandd0ntbreakthe00}


## **NS_0.08** 

il mio pc deve collegarsi in ssh a node3 direttamente al suo indirizzo privato 172.16.44.200 --> senza NAT 

HOST (.1) --- 192.168.123.0/24 --- node1 (.123 | 10.0.0.1) --- 10.0.0.0/24 --- node2 (10.0.0.2 | 172.16.44.100) --- 172.16.44.0/24 --- node3 (.200)

**Su node2 (docker exec -it ns_000-node2-1 bash):**
1. ip a                                          # eth1 deve essere senza IP
2. ip addr add 172.16.44.100/24 dev eth1
3. cat /proc/sys/net/ipv4/ip\_forward         # se è 0: sysctl -w net.ipv4.ip_forward=1
4. ip route                               # deve esserci 192.168.123.0/24 via 10.0.0.1
Se manca la rotta: ip route add 192.168.123.0/24 via 10.0.0.1.

**Su node3 (docker exec -it ns_000-node3-1 bash)**:
1. ip a
2. ip addr add 172.16.44.200/24 dev eth0
3. ip route add default via 172.16.44.100
4. ping -c 3 172.16.44.100                       # test verso node2
Una default route verso node2 è la cosa più semplice, perché node3 ha una sola uscita. In alternativa si piuò aggiungere ip route add 192.168.123.0/24 via 172.16.44.100.

**Su node1 (docker exec -it ns_000-node1-1 bash):**
1. ip route add 172.16.44.0/24 via 10.0.0.2
2. ping -c 3 172.16.44.200                       # test verso node3
Se questo ping funziona, il routing interno è a posto.

**Sul mio PC:**
1. sudo ip route add 172.16.44.0/24 via 192.168.123.123
2. ping -c 3 172.16.44.200
3. ssh root@172.16.44.200 con pass ccit. Al login via SSH
4. CCIT{level8_th3finalsh0tbec4uss}


##**NS_0.09** 

mio PC ──curl :8090/flag──> [frontend :80] ──http://backend:8080──> [backend]
           (porta esposta)        └──── stessa rete Docker ────┘
- Stessa rete: i due container devono potersi parlare.
- Hostname backend: il frontend cerca il backend per nome. Il DNS interno di Docker risolve i nomi solo tra container sulla stessa rete creata dall'utente, quindi non sulla rete bridge di default.
- Porta esposta: solo il frontend va esposto all'esterno. Il backend no, perché lo usa solo il frontend.

Passi

1. Estrai lo zip in una
cd ~/Desktop/ALE/JOURNEY/CTF/CYBERCHALLENGE_2026/CORSO/NETWORK/NET0
mkdir NS_0.09
unzip challenge.zip -d NS_0.09
cd NS_0.09
ls


2. Crea il file docker-ccompose.yml:
services:
  backend:
    build: ./backend
    hostname: backend
    networks:
        - ccit
    frontend:
    build: ./frontend                                                           
    ports:
      - "8090:80"  
    depends_on:
      - backend                                                                 
    networks:
      - ccit                                                                  
networks:                                                                     
ccit:


- build: ./backend costruisce l'immagine dal Dockerfile contenuto in quella   cartella.
- hostname: backend è il nome richiesto dalla challenge. Con compose anche il nome del servizio 
- ports: "8090:80" collega la porta 8090 del mioo PC alla porta 80 del frontend. 
- networks: ccit mette eessa rete personalizzata.
- depends_on avvia il backend prima del frontend.

3. Costruisci e avvia
docker compose up -d --b
La prima volta scarica l'immagine node:14 e ci mette un po'.

4. Controlla che siano attivi
docker compose ps

5. curl http://localhost:8090/flag

6. CCIT{easy\_docker\_easy\_life\_53454}


