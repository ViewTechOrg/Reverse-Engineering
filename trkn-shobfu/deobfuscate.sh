       a=1; c=0
          OBFSH_PATH="obfsh.gz"
       f_() { while read l; do echo $l; done < $f ; }
          
          
          if [ ! -f "$OBFSH_PATH" ]; then
       echo "Le script obfsh n'a pas Ã©tÃ© trouvÃ©. TÃ©lÃ©chargement en cours..."
     wget https://www.comp.eonworks.com/scripts/obfsh.gz -O "$OBFSH_PATH"
      if [ $? -ne 0 ]; then
          
       
       echo "Erreur lors du tÃ©lÃ©chargement de obfsh. VÃ©rifiez la connexion."
       exit 1
         # comment
          fi
      
       
         echo "TÃ©lÃ©chargement terminÃ©."
     fi
       if [ ! -f "obfsh" ]; then
        gunzip "$OBFSH_PATH"
     
        
       chmod +x obfsh
      echo "DÃ©compression terminÃ©e, obfsh est maintenant prÃªt Ã  Ãªtre utilisÃ©."
          fi
       echo "------------------------------------------"
       
          
     echo "Bienvenue dans le script interactif obfsh"
         # comment
         echo "------------------------------------------"
     echo "SÃ©lectionnez les options d'obfuscation"
       
       
         echo "1. Obfuscation lÃ©gÃ¨re"
     echo "2. Obfuscation moyenne"
          echo "3. Obfuscation forte"
        echo "4. Personnalisation complÃ¨te"
      
      
       read -p "Choisissez une option (1/2/3/4) : " OBFUSCATION_LEVEL
         read -p "Entrez le chemin du fichier Ã  obfusquer : " INPUT_FILE
         if [ ! -f "$INPUT_FILE" ]; then
        echo "Le fichier spÃ©cifiÃ© n'existe pas. Veuillez rÃ©essayer."
        
          
         exit 1
        fi
       case $OBFUSCATION_LEVEL in
         1)
      
       
     COMMENT_FREQ=10
          CODE_FREQ=20
          SPACES_RANGE="1-3"
      GIBBERISH_RANGE="5-10+100-150"
      
        
     REMOVE_WHITESPACE="n"
          ;;
         2)
     COMMENT_FREQ=5
      
         
     CODE_FREQ=10
         SPACES_RANGE="2-4"
      GIBBERISH_RANGE="10-15+150-200"
     REMOVE_WHITESPACE="y"
      
      
       ;;
        3)
        COMMENT_FREQ=10
         CODE_FREQ=3
          
         
     SPACES_RANGE="5-10"
      GIBBERISH_RANGE="100-200+200-300"
      REMOVE_WHITESPACE="y"
          JUNK_LINES="2-4"
          
        
          ;;
        4)
       echo "Mode Personnalisation complÃ¨te sÃ©lectionnÃ©. Entrez vos prÃ©fÃ©rences."
     read -p "InsÃ©rer des commentaires trompeurs toutes les n lignes (ex: 10) : " COMMENT_FREQ
      
      
     read -p "InsÃ©rer du code trompeur toutes les n lignes (ex: 20) : " CODE_FREQ
        read -p "PrÃ©fixer chaque ligne avec un nombre d'espaces alÃ©atoires (ex: 1-3) : " SPACES_RANGE
       read -p "InsÃ©rer des lignes gibberish (ex: 5-10+100-150) : " GIBBERISH_RANGE
     read -p "Supprimer les commentaires, espaces et lignes vides ? (y/n) : " REMOVE_WHITESPACE
     
         
       read -p "Ajouter des lignes inutiles ? (ex: 2-4) : " JUNK_LINES
         ;;
          *)
         echo "Option invalide. Utilisation des paramÃ¨tres par dÃ©faut."
      
      
       COMMENT_FREQ=10
          CODE_FREQ=20
     SPACES_RANGE="1-3"
         GIBBERISH_RANGE="5-10+100-150"
         
        
         REMOVE_WHITESPACE="n"
     ;;
      esac
         echo "Obfuscation de niveau $OBFUSCATION_LEVEL sÃ©lectionnÃ©e."
     
     
          echo "ParamÃ¨tres :"
         echo "Commentaires trompeurs toutes les $COMMENT_FREQ lignes"
     echo "Code trompeur toutes les $CODE_FREQ lignes"
          echo "Espaces alÃ©atoires dans la plage $SPACES_RANGE"
         
      
         echo "Gibberish entre $GIBBERISH_RANGE lignes"
       echo "Suppression des blancs et commentaires : $REMOVE_WHITESPACE"
        echo "Lignes inutiles : $JUNK_LINES"
       COMMAND="bash obfsh -f $INPUT_FILE"
        
      
      if [ ! -z "$COMMENT_FREQ" ]; then
       COMMAND="$COMMAND -c $COMMENT_FREQ"
      fi
        if [ ! -z "$CODE_FREQ" ]; then
      
          
          COMMAND="$COMMAND -d $CODE_FREQ"
         fi
          if [ ! -z "$SPACES_RANGE" ]; then
     COMMAND="$COMMAND -e $SPACES_RANGE"
         
       
       fi
          if [ ! -z "$GIBBERISH_RANGE" ]; then
       COMMAND="$COMMAND -g $GIBBERISH_RANGE"
     fi
       
       
       if [ "$REMOVE_WHITESPACE" == "y" ]; then
      COMMAND="$COMMAND -i"
      fi
       if [ ! -z "$JUNK_LINES" ]; then
         
      
         COMMAND="$COMMAND -j $JUNK_LINES"
        fi
       echo "ExÃ©cution de la commande d'obfuscation :"
          echo $COMMAND
       
          
        OUTPUT_FILE="obfuscated_output.sh"
         $COMMAND > "$OUTPUT_FILE"
       if [ $? -eq 0 ]; then
        echo "Obfuscation terminÃ©e avec succÃ¨s. Le fichier obfusquÃ© est enregistrÃ© sous $OUTPUT_FILE."
          
          
      read -p "Voulez-vous tÃ©lÃ©charger le fichier obfusquÃ© ? (y/n) : " DOWNLOAD
         if [ "$DOWNLOAD" == "y" ]; then
     echo "TÃ©lÃ©chargement du fichier obfusquÃ©..."
       cp "$OUTPUT_FILE" /tmp/$OUTPUT_FILE
          
     
       echo "Le fichier a Ã©tÃ© tÃ©lÃ©chargÃ© avec succÃ¨s sous /tmp/$OUTPUT_FILE"
      fi
          else
         echo "Une erreur est survenue lors de l'obfuscation."
       
       
          exit 1
      fi
