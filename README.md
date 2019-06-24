# traefik_ci
<p><h3>Complex Contionous integration environment with traefik reverse proxy (http only)</p></h3>
<p><h4>Installation Prerequisites:</h4></p>
<p>Install docker compose according offical documentation https://docs.docker.com/compose/install/</br>
Install Docker Community Edition (CE) documentation https://docs.docker.com/install/</p>
<h4><p>Tested version:</p></h4>
<p>Docker Compose: 1:24</p>
<p>Docker CE: 18.09.2</p>

<h4>Installation:</h4>
<p><code>$cd /</code> </br>
<code>$mkdir my_project</code></br>
<code>$cd my_project</code></br>
<code>$git clone https://github.com/devuserPP/traefik_ci.git</code></br>
<code>$cd traefik</code></br>
<code>$docker-compose up -d --force-recreate</code></p>

<b> Traefik should start and could be accesible on http://localhost:8090/dasboard </b>

<h4>Now we try to start aplications which will be accesible over treafik proxy:</h4>
<p><code>$cd / </code></br>
<code>$cd /my_project/traefik_ci/app </code></br>
<code>$docker-compose up -d --force-recreate --build </code></br></p>

<h4>after some wait we should be able run following applications:</h4>
<ul>
<li>Jenkins>http://localhost:90/jenkins</li>
<li>SonarQube>http://localhost:90/sonar</li>
<li>Nexus>http://localhost:90/nexus</p></li>
