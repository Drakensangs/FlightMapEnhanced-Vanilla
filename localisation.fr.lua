-- French localisation

if (GetLocale() == "frFR") then
    BINDING_HEADER_FLIGHTMAP = "Carte de vol";
    BINDING_NAME_FLIGHTMAP   = "Afficher la carte de vol";

    FLIGHTMAP_NAME          = "Carte de vol";
    FLIGHTMAP_DESCRIPTION   = "Informations sur les vols";
    FLIGHTMAP_ALLIANCE      = "Alliance";
    FLIGHTMAP_HORDE         = "Horde";
    FLIGHTMAP_CONTESTED     = "Contesté";

    -- Zone names
    FLIGHTMAP_MOONGLADE     = "Reflet-de-Lune";
    FLIGHTMAP_ELWYNN        = "Forêt d'Elwynn";
    FLIGHTMAP_DUNMOROGH     = "Dun Morogh";
    FLIGHTMAP_TIRISFAL      = "Clairières de Tirisfal";
    FLIGHTMAP_LOCHMODAN     = "Loch Modan";
    FLIGHTMAP_SILVERPINE    = "Forêt des Pins argentés";
    FLIGHTMAP_WESTFALL      = "La Marche de l'Ouest";
    FLIGHTMAP_REDRIDGE      = "Les Carmines";
    FLIGHTMAP_DUSKWOOD      = "Bois de la pénombre";
    FLIGHTMAP_HILLSBRAD     = "Contreforts de Hautebrande";
    FLIGHTMAP_WETLANDS      = "Les Paluns";
    FLIGHTMAP_ALTERAC       = "Montagnes d'Alterac";
    FLIGHTMAP_ARATHI        = "Hautes-terres d'Arathi";
    FLIGHTMAP_STRANGLETHORN = "Vallée de Strangleronce";
    FLIGHTMAP_BADLANDS      = "Terres Ingrates";
    FLIGHTMAP_SORROWS       = "Marais des chagrins";
    FLIGHTMAP_HINTERLANDS   = "Les Hinterlands";
    FLIGHTMAP_SEARINGGORGE  = "Gorges des Vents brûlants";
    FLIGHTMAP_BLASTEDLANDS  = "Terres Foudroyées";
    FLIGHTMAP_BURNINGSTEPPE = "Steppes ardentes";
    FLIGHTMAP_WESTERNPLAGUE = "Maleterres de l'Ouest";
    FLIGHTMAP_EASTERNPLAGUE = "Maleterres de l'Est";
    FLIGHTMAP_DUROTAR       = "Durotar";
    FLIGHTMAP_MULGORE       = "Mulgore";
    FLIGHTMAP_DARKSHORE     = "Sombrivage";
    FLIGHTMAP_BARRENS       = "Les Tarides";
    FLIGHTMAP_STONETALON    = "Les Serres-Rocheuses";
    FLIGHTMAP_ASHENVALE     = "Ashenvale";
    FLIGHTMAP_1KNEEDLES     = "Mille pointes";
    FLIGHTMAP_DESOLACE      = "Désolace";
    FLIGHTMAP_DUSTWALLOW    = "Marécage d'Âprefange";
    FLIGHTMAP_FERALAS       = "Féralas";
    FLIGHTMAP_TANARIS       = "Tanaris";
    FLIGHTMAP_AZSHARA       = "Azshara";
    FLIGHTMAP_FELWOOD       = "Gangrebois";
    FLIGHTMAP_UNGOROCRATER  = "Cratère d'Un'Goro";
    FLIGHTMAP_SILITHUS      = "Silithus";
    FLIGHTMAP_WINTERSPRING  = "Berceau-de-l'Hiver";
    FLIGHTMAP_TELDRASSIL    = "Teldrassil";
    FLIGHTMAP_DEADWINDPASS  = "Défilé de Deuillevent";
    FLIGHTMAP_ORGRIMMAR     = "Orgrimmar";
    FLIGHTMAP_THUNDERBLUFF  = "Pitons-du-Tonnerre";
    FLIGHTMAP_UNDERCITY     = "Les Fossoyeuses";
    FLIGHTMAP_IRONFORGE     = "Forgefer";
    FLIGHTMAP_STORMWIND     = "Hurlevent";
    FLIGHTMAP_DARNASSUS     = "Darnassus";

    -- General strings
    FLIGHTMAP_TIMING        = "(calcul)";
    FLIGHTMAP_LEVELS        = "Niveaux : %d - %d";
    FLIGHTMAP_NOFLIGHTS     = "Aucun connu!";
    FLIGHTMAP_NOT_KNOWN     = "(Inconnu)";
    FLIGHTMAP_NO_COST       = "Gratuit";
    FLIGHTMAP_MONEY_GOLD    = "o";
    FLIGHTMAP_MONEY_SILVER  = "a";
    FLIGHTMAP_MONEY_COPPER  = "c";
    FLIGHTMAP_FLIGHTTIME    = "Temps de vol: ";
    FLIGHTMAP_QUICKEST      = "Trajet le plus rapide";
    FLIGHTMAP_TOTAL_TIME    = "Temps total";
    FLIGHTMAP_VIA           = "Via ";
    FLIGHTMAP_CONFIRM       = "Voulez-vous vraiment rejoindre %s?%s";
    FLIGHTMAP_CONFIRM_TIME  = " Ce vol prendra ";

    -- Command strings
    FLIGHTMAP_RESET         = "réinitialiser";
    FLIGHTMAP_SHOWMAP       = "ouvrir";
    FLIGHTMAP_LOCKTIMES     = "verrouiller";

    -- Help text
    FLIGHTMAP_TIMER_HELP    =
        "Maintenez la touche MAJ enfoncée et faites glisser la barre du minuteur pour la repositionner.";

    -- Option strings
    FLIGHTMAP_OPTIONS_CLOSE = "Fermer";
    FLIGHTMAP_OPTIONS_TITLE = "Options FlightMap";
    FLIGHTMAP_OPTIONS = {};
    FLIGHTMAP_OPTIONS[1] = {   -- Option 1: flight path lines
        label = "Lignes de trajets",
        option = "showPaths",
        tooltip = "Dessine les trajets aériens sur la carte du monde.",
    };
    FLIGHTMAP_OPTIONS[2] = {   -- Option 2: extra POI buttons
        label = "IC de maîtres de vol",
        option = "showPOIs",
        tooltip = "Affiche des icônes supplémentaires sur la carte du monde pour les maîtres de vol.",
        children = {12, 13},
    };
    FLIGHTMAP_OPTIONS[12] = {   -- Option 12: continent POI icons
        label = "Icônes de maîtres de vol (continent)",
        option = "showContinentPOIs",
        tooltip = "Afficher les icônes des maîtres de vol sur les cartes de continent.",
    };
    FLIGHTMAP_OPTIONS[13] = {   -- Option 13: POI tooltips
        label = "Infobulle des maîtres de vol",
        option = "showPOITooltips",
        tooltip = "Afficher une infobulle au survol d'une icône de maître de vol.",
    };
    FLIGHTMAP_OPTIONS[3] = {   -- Option 3: Unknown masters
        label = "Afficher toutes les infos",
        option = "showAllInfo",
        tooltip = "Afficher toutes les données, même pour les maîtres de vol non visités.",
    };
    FLIGHTMAP_OPTIONS[4] = {   -- Option 4: Auto-Dismount
        label = "Démonture automatique",
        option = "autoDismount",
        tooltip = "Se démonter automatiquement en parlant à un maître de vol.",
    };
    FLIGHTMAP_OPTIONS[5] = {   -- Option 5: flight timers
        label = "Compteur durant le vol",
        option = "useTimer",
        tooltip = "Active/Supprime le la barre de durée du trajet.",
    };
    FLIGHTMAP_OPTIONS[6] = {   -- Option 6: Show flight destinations
        label = "Afficher les destinations",
        option = "showDestinations",
        tooltip = "Afficher les destinations de vol dans les infobulles.",
        children = {7, 8, 9},
    };
    FLIGHTMAP_OPTIONS[7] = {   -- Option 7: Show multi-hop destinations
        label = "Y compris les escales",
        option = "showMultiHop",
        tooltip = "Afficher les destinations avec escales dans les infobulles.",
    };
    FLIGHTMAP_OPTIONS[8] = {   -- Option 8: Show flight times
        label = "Avec les durées de vol",
        option = "showTimes",
        tooltip = "Afficher les durées de vol dans les infobulles.",
    };
    FLIGHTMAP_OPTIONS[9] = {   -- Option 9: Show flight costs
        label = "Avec les coûts de vol",
        option = "showCosts",
        tooltip = "Afficher les coûts de vol dans les infobulles.",
    };
    FLIGHTMAP_OPTIONS[10] = {   -- Option 10: Taxi window extras 
        label = "Carte de vol complète",
        option = "fullTaxiMap",
        tooltip = "Afficher les nœuds inaccessibles sur la carte de la fenêtre de vol.",
    };
    FLIGHTMAP_OPTIONS[11] = {   -- Option 11: Confirm flight destinations
        label = "Confirmer les vols",
        option = "confirmFlights",
        tooltip = "Demander une confirmation avant de prendre un vol.",
    };
    FLIGHTMAP_OPTIONS[14] = {   -- Option 14: zone tooltip
        label = "Afficher l'infobulle de zone",
        option = "showZoneTooltip",
        tooltip = "Afficher une infobulle pour la zone sur la carte du continent.",
	    children = {15},
    };
    FLIGHTMAP_OPTIONS[15] = {   -- Option 15: zone level ranges
        label = "Niveaux de zone",
        option = "showLevelRanges",
        tooltip = "Afficher les niveaux recommandés pour chaque zone.",
    };
    FLIGHTMAP_OPTIONS[16] = {   -- Option 16: UnitXP notify taskbar
        label = "Notif. : icône de la barre des tâches",
        option = "notifyTaskbar",
        tooltip = "Faire clignoter l'icône de la barre des tâches à l'atterrissage.",
    };
    FLIGHTMAP_OPTIONS[17] = {   -- Option 17: UnitXP notify sound
        label = "Notif. : son système",
        option = "notifySound",
        tooltip = "Jouer un son système à l'atterrissage.",
    };
    FLIGHTMAP_OPTIONS[18] = {   -- Option 18: Minimap button
        label = "Bouton de la minicarte",
        option = "showMinimapButton",
        tooltip = "Affiche un bouton FlightMap sur la minicarte.",
    };
    FLIGHTMAP_OPTIONS[19] = {   -- Option 19: Lock flight times
        label = "Verrouiller les temps de vol",
        option = "lockFlightTimes",
        tooltip = "Empêche l'addon d'enregistrer de nouvelles données de vol dans les variables sauvegardées.",
    };

    FLIGHTMAP_TOOLTIP_FONT_SIZE             = "Taille de police de l'infobulle";
    FLIGHTMAP_TOOLTIP_FONT_SIZE_TIP         = "Règle la taille de police du texte de l'infobulle FlightMap.";
    FLIGHTMAP_MINIMAP_TIP1                  = "Clic gauche pour ouvrir le menu FlightMap.";
    FLIGHTMAP_MINIMAP_TIP2                  = "Maintenir le clic droit pour déplacer le bouton de la minicarte.";
    FLIGHTMAP_MINIMAP_TIP3                  = "Ctrl + clic gauche pour ouvrir la carte des vols.";
    FLIGHTMAP_MINIMAP_TIP4                  = "Maj + clic gauche pour réinitialiser la position de la barre de minuterie.";

    -- These constants determine how "Town, Zone" strings look.
    -- SEP_STRING is what separates Town from Zone.  SEP_POSTAMBLE
    -- is anything that is after Zone.
    FLIGHTMAP_SEP_STRING    = ", ";
    FLIGHTMAP_SEP_POSTAMBLE = "";
end
