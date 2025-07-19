?><?php
if(!file_exists('obfuscate.php') || !file_exists('bin/colors.php') || !file_exists('bin/header.php'))
{
	echo "\nSome Files Missing , Please Download The Tool Again\nYou Can Download it With This Command:\ngit clone https://github.com/Rizer/Blind-Bash\n\n";
	exit(0);
}
else
{
	require('obfuscate.php');
	require('bin/colors.php');
	require('bin/header.php');
}
head();
$filename = readline("Ruta del scritp bash >> $green");
$filename = trim($filename);
$filename = "".$filename;
if(file_exists($filename))
{
$out = readline("\e[91mnuevo nombre >> $green");
$out = "Gray/".$out;
obfuscate($filename,$out);
}
else
{
	echo "$filename el scritp no existe :v\n";
}
?>
