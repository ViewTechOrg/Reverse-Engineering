# trkn-shobfu

## Description

**trkn-shobfu** est un script Bash interactif conçu pour obfusquer des fichiers de manière personnalisée. Il permet à l'utilisateur de choisir parmi plusieurs niveaux d'obfuscation prédéfinis ou de personnaliser les paramètres d'obfuscation pour des besoins spécifiques.

![Image Preview](https://h.top4top.io/p_3412c0kzo0.jpg)

Ce script utilise le [obfsh](https://www.comp.eonworks.com/scripts/obfsh.gz) pour effectuer l'obfuscation, et propose une interface utilisateur simple pour faciliter le choix des options d'obfuscation.

## Fonctionnalités

- **Obfuscation légère** : Applique des modifications de base comme l'ajout de commentaires et d'espaces aléatoires.
- **Obfuscation moyenne** : Un compromis entre la simplicité et la complexité avec plus de commentaires et de gibberish.
- **Obfuscation forte** : Très complexe, avec de nombreux commentaires trompeurs, lignes de code inutiles et suppression des espaces.
- **Personnalisation complète** : Permet à l'utilisateur de définir ses propres paramètres d'obfuscation (commentaires, code trompeur, gibberish, etc.).

## Prérequis

- **bash** : Le script est conçu pour fonctionner sous un environnement bash.
- **wget** : Pour télécharger le script `obfsh` si nécessaire.
- **gunzip** : Pour décompresser le fichier `obfsh.gz`.

## Installation

1. Clonez le dépôt sur votre machine :

```bash
git clone https://github.com/trh4ckn0n/trkn-shobfu
cd trkn-shobfu
``` 
 
2.  
Assurez-vous que le script `bashobfu.sh` est exécutable :
 ```bash
 chmod +x bashobfu.sh `
 ```

3.  
Exécutez le script avec :
 ```bash
 ./bashobfu.sh
 ```

## Utilisation

Lorsque vous exécutez le script, il vous sera demandé de choisir le niveau d'obfuscation :

1. **Obfuscation légère** : Applique une obfuscation minimale.
2. **Obfuscation moyenne** : Applique une obfuscation modérée.
3. **Obfuscation forte** : Applique une obfuscation complexe.
4. **Personnalisation complète** : Permet de personnaliser les paramètres d'obfuscation.

Le script demande également le fichier à obfusquer et propose de télécharger le fichier obfusqué une fois l'obfuscation terminée.

## Options de personnalisation

Si vous choisissez l'option **Personnalisation complète**, vous pouvez définir des paramètres d'obfuscation spécifiques, tels que :

- Le nombre de commentaires ajoutés.
- La quantité de gibberish (code aléatoire) inséré.
- La suppression ou l'ajout d'espaces.

Les paramètres sont ajustés à l'aide de menus interactifs simples, ce qui permet de contrôler finement l'obfuscation du fichier.

## Téléchargement du fichier obfusqué

Une fois l'obfuscation terminée, le script offre la possibilité de télécharger le fichier obfusqué généré. Le fichier sera sauvegardé avec un nom modifié pour éviter de remplacer l'original. Vous pouvez ensuite utiliser ce fichier obfusqué dans vos projets ou tests de sécurité.

## Exemple d'exécution


```bash
./bashobfu.sh
```

Choisissez le niveau d'obfuscation :
1. Obfuscation légère
2. Obfuscation moyenne
3. Obfuscation forte
4. Personnalisation complète

Entrez votre choix : 3

Entrez le fichier à obfusquer : script.sh

L'obfuscation est en cours...

Le fichier obfusqué a été généré sous le nom script_obfusque.sh.

