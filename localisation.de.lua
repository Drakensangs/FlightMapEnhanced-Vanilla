-- German localisation

if (GetLocale() == "deDE") then
    BINDING_HEADER_FLIGHTMAP = "Flugkarte";
    BINDING_NAME_FLIGHTMAP   = "Zeige Flugkarte";

    FLIGHTMAP_NAME          = "Flugkarte";
    FLIGHTMAP_DESCRIPTION   = "Fluglinieninfos auf der Weltkarte";
    FLIGHTMAP_ALLIANCE      = "Allianz";
    FLIGHTMAP_HORDE         = "Horde";
    FLIGHTMAP_CONTESTED     = "Umkämpft";

    -- Zone names
    FLIGHTMAP_MOONGLADE     = "Mondlichtung";
    FLIGHTMAP_ELWYNN        = "Wald von Elwynn";
    FLIGHTMAP_DUNMOROGH     = "Dun Morogh";
    FLIGHTMAP_TIRISFAL      = "Tirisfal";
    FLIGHTMAP_LOCHMODAN     = "Loch Modan";
    FLIGHTMAP_SILVERPINE    = "Silberwald";
    FLIGHTMAP_WESTFALL      = "Westfall";
    FLIGHTMAP_REDRIDGE      = "Rotkammgebirge";
    FLIGHTMAP_DUSKWOOD      = "Dämmerwald";
    FLIGHTMAP_HILLSBRAD     = "Vorgebirge des Hügellands";
    FLIGHTMAP_WETLANDS      = "Das Sumpfland";
    FLIGHTMAP_ALTERAC       = "Das Alteracgebirge";
    FLIGHTMAP_ARATHI        = "Das Arathihochland";
    FLIGHTMAP_STRANGLETHORN = "Schlingendorntal";
    FLIGHTMAP_BADLANDS      = "Das Ödland";
    FLIGHTMAP_SORROWS       = "Sümpfe des Elends";
    FLIGHTMAP_HINTERLANDS   = "Das Hinterland";
    FLIGHTMAP_SEARINGGORGE  = "Die sengende Schlucht";
    FLIGHTMAP_BLASTEDLANDS  = "Die verwüsteten Lande";
    FLIGHTMAP_BURNINGSTEPPE = "Die brennende Steppe";
    FLIGHTMAP_WESTERNPLAGUE = "Die westlichen Pestländer";
    FLIGHTMAP_EASTERNPLAGUE = "Die östlichen Pestländer";
    FLIGHTMAP_DUROTAR       = "Durotar";
    FLIGHTMAP_MULGORE       = "Mulgore";
    FLIGHTMAP_DARKSHORE     = "Dunkelküste";
    FLIGHTMAP_BARRENS       = "Das Brachland";
    FLIGHTMAP_STONETALON    = "Das Steinkrallengebirge";
    FLIGHTMAP_ASHENVALE     = "Eschental";
    FLIGHTMAP_1KNEEDLES     = "Tausend Nadeln";
    FLIGHTMAP_DESOLACE      = "Desolace";
    FLIGHTMAP_DUSTWALLOW    = "Düstermarschen";
    FLIGHTMAP_FERALAS       = "Feralas";
    FLIGHTMAP_TANARIS       = "Tanaris";
    FLIGHTMAP_AZSHARA       = "Azshara";
    FLIGHTMAP_FELWOOD       = "Teufelswald";
    FLIGHTMAP_UNGOROCRATER  = "Der Un'Goro Krater";
    FLIGHTMAP_SILITHUS      = "Silithus";
    FLIGHTMAP_WINTERSPRING  = "Winterquell";
    FLIGHTMAP_TELDRASSIL    = "Teldrassil";
    FLIGHTMAP_DEADWINDPASS  = "Der Gebirgspass der Totenwinde";
    FLIGHTMAP_ORGRIMMAR     = "Orgrimmar";
    FLIGHTMAP_THUNDERBLUFF  = "Donnerfels";
    FLIGHTMAP_UNDERCITY     = "Unterstadt";
    FLIGHTMAP_IRONFORGE     = "Eisenschmiede";
    FLIGHTMAP_STORMWIND     = "Sturmwind";
    FLIGHTMAP_DARNASSUS     = "Darnassus";

    -- General strings:
    FLIGHTMAP_TIMING        = "(Zeitberechnung)";
    FLIGHTMAP_LEVELS        = "Zonen-Level: %d - %d";
    FLIGHTMAP_NOFLIGHTS     = "Keine bekannt!";
    FLIGHTMAP_NOT_KNOWN     = "(Nicht bekannt)";
    FLIGHTMAP_NO_COST       = "Kostenlos";
    FLIGHTMAP_MONEY_GOLD    = "G";
    FLIGHTMAP_MONEY_SILVER  = "S";
    FLIGHTMAP_MONEY_COPPER  = "K";
    FLIGHTMAP_FLIGHTTIME    = "Flugzeit: ";
    FLIGHTMAP_QUICKEST      = "Schnellste Verbindung";
    FLIGHTMAP_TOTAL_TIME    = "Gesamtdauer";
    FLIGHTMAP_VIA           = "über ";
    FLIGHTMAP_CONFIRM       = "Bist du sicher dass du nach %s fliegen willst?%s";
    FLIGHTMAP_CONFIRM_TIME  = " Dieser Flug dauert ";

    -- Command strings
    FLIGHTMAP_RESET         = "Zurücksetzen";
    FLIGHTMAP_SHOWMAP       = "öffnen";
    FLIGHTMAP_LOCKTIMES     = "Sperren";

    -- Help text
    FLIGHTMAP_TIMER_HELP    =
        "Halte die SHIFT-Taste gedrückt und verschiebe die Zeitleiste zum neuanordnen.";

    -- Option strings:
    FLIGHTMAP_OPTIONS_CLOSE = "Schließen";
    FLIGHTMAP_OPTIONS_TITLE = "FlightMap Optionen";
    FLIGHTMAP_OPTIONS = {};
    FLIGHTMAP_OPTIONS[1] = {   -- Option 1: flight path lines
        label = "Flugrouten-Linien",
        option = "showPaths",
        tooltip = "Flugrouten auf der Weltkarte mit Linien anzeigen.",
    };
    FLIGHTMAP_OPTIONS[2] = {   -- Option 2: extra POI buttons
        label = "Flugmeister-Symbole",
        option = "showPOIs",
        tooltip = "Flugmeister auf der Weltkarte mit Symbolen anzeigen.",
        children = {12, 13},
    };
    FLIGHTMAP_OPTIONS[12] = {   -- Option 12: continent POI icons
        label = "Flugmeister Kontinent-Symbole",
        option = "showContinentPOIs",
        tooltip = "Flugmastersymbole auf der Kontinentkarte anzeigen.",
    };
    FLIGHTMAP_OPTIONS[13] = {   -- Option 13: POI tooltips
        label = "Flugmeister-Tooltip",
        option = "showPOITooltips",
        tooltip = "Tooltip anzeigen wenn die Maus über ein Flugmeister-Symbol bewegt wird.",
    };
    FLIGHTMAP_OPTIONS[3] = {   -- Option 3: Unknown masters
        label = "Zeige alle Infos",
        option = "showAllInfo",
        tooltip = "Alle Infos auf der Weltkarte anzeigen (auch für unbesuchte Flugpunkte).",
    };
    FLIGHTMAP_OPTIONS[4] = {   -- Option 4: Auto-Dismount
        label = "Auto-absteigen",
        option = "autoDismount",
        tooltip = "Automatisch vom Reittier absteigen, wenn man mit einem Flugmeister spricht.",
    };
    FLIGHTMAP_OPTIONS[5] = {   -- Option 5: flight timers
        label = "Restdauer-Anzeige",
        option = "useTimer",
        tooltip = "Zeitanzeige im Flugmodus ein-/ausschalten.",
    };
    FLIGHTMAP_OPTIONS[6] = {   -- Option 6: Show flight destinations
        label = "Zeige Zielorte",
        option = "showDestinations",
        tooltip = "Zeige Flugziele im Tooltip.",
        children = {7, 8, 9},
    };
    FLIGHTMAP_OPTIONS[7] = {   -- Option 7: Show multi-hop destinations
        label = "Multi-hop einbeziehen",
        option = "showMultiHop",
        tooltip = "Mehrstoppziele in den Tooltips anzeigen.",
    };
    FLIGHTMAP_OPTIONS[8] = {   -- Option 8: Show flight times
        label = "Zeige Flugdauer",
        option = "showTimes",
        tooltip = "Flugzeiten im Tooltip anzeigen.",
    };
    FLIGHTMAP_OPTIONS[9] = {   -- Option 9: Show flight costs
        label = "Zeige Flugkosten",
        option = "showCosts",
        tooltip = "Flugkosten im Tooltip anzeigen.",
    };
    FLIGHTMAP_OPTIONS[10] = {   -- Option 10: Taxi window extras
        label = "Vollständige Flugkarte",
        option = "fullTaxiMap",
        tooltip = "Zeige alle Flugpunkte im Flugmeister-Fenster.",
    };
    FLIGHTMAP_OPTIONS[11] = {   -- Option 11: Confirm flight destinations
        label = "Flüge bestätigen",
        option = "confirmFlights",
        tooltip = "Nachfragen bevor die Flüge starten.",
    };
    FLIGHTMAP_OPTIONS[14] = {   -- Option 14: zone tooltip
        label = "Zonentooltip anzeigen",
        option = "showZoneTooltip",
        tooltip = "Einen Tooltip für die Zone auf der Kontinentkarte anzeigen.",
		children = {15},
    };
    FLIGHTMAP_OPTIONS[15] = {   -- Option 15: zone level ranges
        label = "Zonenlevelbereiche anzeigen",
        option = "showLevelRanges",
        tooltip = "Den empfohlenen Levelbereich für jede Zone anzeigen.",
    };
    FLIGHTMAP_OPTIONS[16] = {   -- Option 16: UnitXP notify taskbar
        label = "Benachrichtigung: Taskleistensymbol",
        option = "notifyTaskbar",
        tooltip = "Taskleistensymbol bei Ankunft blinken lassen.",
    };
    FLIGHTMAP_OPTIONS[17] = {   -- Option 17: UnitXP notify sound
        label = "Benachrichtigung: Systemklang",
        option = "notifySound",
        tooltip = "Systemklang bei Ankunft abspielen.",
    };
    FLIGHTMAP_OPTIONS[18] = {   -- Option 18: Minimap button
        label = "Minimap-Schaltfläche",
        option = "showMinimapButton",
        tooltip = "Zeigt eine FlightMap-Schaltfläche auf der Minimap an.",
    };
    FLIGHTMAP_OPTIONS[19] = {   -- Option 19: Lock flight times
        label = "Flugzeiten sperren",
        option = "lockFlightTimes",
        tooltip = "Verhindert, dass das Addon neue oder abweichende Flugdaten in den gespeicherten Variablen speichert.",
    };

    FLIGHTMAP_TOOLTIP_FONT_SIZE             = "Tooltip-Schriftgröße";
    FLIGHTMAP_TOOLTIP_FONT_SIZE_TIP         = "Schriftgröße des FlightMap-Tooltip-Texts anpassen.";
    FLIGHTMAP_MINIMAP_TIP1                  = "Linksklick, um das FlightMap-Menü zu öffnen.";
    FLIGHTMAP_MINIMAP_TIP2                  = "Rechtsklick halten, um den Minimap-Knopf zu bewegen.";
    FLIGHTMAP_MINIMAP_TIP3                  = "Strg + Linksklick, um die Flugkarte zu öffnen.";
    FLIGHTMAP_MINIMAP_TIP4                  = "Shift + Linksklick, um die Timerleistenposition zurückzusetzen.";

    -- These constants determine how "Town, Zone" strings look.
    -- SEP_STRING is what separates Town from Zone.  SEP_POSTAMBLE
    -- is anything that is after Zone.
    FLIGHTMAP_SEP_STRING    = ", ";
    FLIGHTMAP_SEP_POSTAMBLE = "";
end
