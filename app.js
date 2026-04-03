let t,i,s;
function v(p){navigator.vibrate&&navigator.vibrate(p);}
function set(t1){document.getElementById("status").innerText=t1;}
function startTransport(){stopAll();set("Indução ativa");t=setInterval(()=>v([180]),1000);setTimeout(startShield,900000);}
function startInvite(){stopAll();set("Transição suave");i=setInterval(()=>{v([400]);setTimeout(()=>v(0),4000);},6000);setTimeout(startShield,900000);}
function startShield(){stopAll();set("Proteção ativa");s=setInterval(()=>v([60]),5000);}
function stopAll(){clearInterval(t);clearInterval(i);clearInterval(s);v(0);set("Inativo");}