// :) HAI HAI HAI JANGAN D RECODE YAH ASW

// Fungsi untuk mengubah string ke bentuk \xXX (hex)
var h = (s, e = true) => {
  var a = s
    .split("")
    .map(x => `\\x${Number(x.charCodeAt(0)).toString(16)}`)
    .join("");
  return e ? ["$'", "'"].join(a) : `'${a}'`;
};

// Fungsi untuk membuat nama variabel random dari a-z dan _
var r = n => {
  var a = "abcdefghijklmnopqrstuvwxyz_";
  var r = "";
  for (i = 0; i < n; i++) {
    r += a[Math.floor(Math.random() * a.length)];
  }
  return r;
};

// Fungsi pembuat kode shell obfuscated
var j = (c, s) => {
  var c1 = c.slice(0, c.length / 2) + "'";
  var c2 = "'" + c.slice(c.length / 2, c.length);

  var v1 = r(s),
      v2 = r(s),
      v3 = r(s),
      v4 = r(s),
      v5 = r(s),
      v6 = r(s),
      v7 = r(s);

  var ok = h(btoa(`${v5}="\\x00";${v6}="\\x00";if ! [[ "$${v1}" =~ ${h('echo')} ]];then ${v5}=${c1};${v6}=${c2};else ${h("rm")} ${h("-rf")} $${v7};fi`));

  return (
    `#tool made by maoundis from xiuz code\n` +
    `#${window.location.href}\n\n\n` +
    `${h("eval")} ${h(v7 + "=$0")};` +
    `${v1}=$(${h("cat")} $${v7});` +
    `${v2}=\${#${v1}};` +
    `while true;do if(( \${#${v2}} == 2 ));then break;fi;${v2}=$(( $${v2} / 2 ));done;` +
    `${v3}=${ok};` +
    `${h("eval")} $(${h("base64")} ${h("-d")} <<< $${v3});` +
    `${v4}=${ok};` +
    `${h("eval")} $(${h("base64")} ${h("-d")} <<< $${v4});` +
    `${h("eval")} $(${h("echo")} ${h("-e")} $(${h("sed")} "s/x00/x$${v2}/g" <<< $${v5}$${v6}))`
  );
};

// Fungsi utama untuk obfuscate shell script
var obf = async (i, c = 500) => {
  var a = `${h("eval")} $(${h("echo")} ${h(btoa(i))} | ${h("base64")} ${h("-d")})`;
  a = h(a, false);

  var b = j(a, c).length;

  while (true) {
    if (b.toString().length === 2) {
      i = b;
      break;
    }
    b = Math.floor(b / 2);
  }

  return j(a.replace(new RegExp("`x" + b + "`", "g"), 'x00'), c);
};
