-- Korean localisation

if (GetLocale() == "koKR") then
    BINDING_HEADER_FLIGHTMAP = "FlightMap";
    BINDING_NAME_FLIGHTMAP   = "비행 지도 표시";

    FLIGHTMAP_NAME          = "FlightMap";
    FLIGHTMAP_DESCRIPTION   = "세계 지도에서 비행 경로 정보 표시";
    FLIGHTMAP_ALLIANCE      = "얼라이언스";
    FLIGHTMAP_HORDE         = "호드";
    FLIGHTMAP_CONTESTED     = "분쟁 지역";

    -- Zone names
    FLIGHTMAP_MOONGLADE     = "달의 숲";
    FLIGHTMAP_ELWYNN        = "엘윈 숲";
    FLIGHTMAP_DUNMOROGH     = "던 모로";
    FLIGHTMAP_TIRISFAL      = "티리스팔 숲";
    FLIGHTMAP_LOCHMODAN     = "모단 호수";
    FLIGHTMAP_SILVERPINE    = "은빛소나무 숲";
    FLIGHTMAP_WESTFALL      = "서부 몰락지대";
    FLIGHTMAP_REDRIDGE      = "붉은마루 산맥";
    FLIGHTMAP_DUSKWOOD      = "그늘숲";
    FLIGHTMAP_HILLSBRAD     = "힐스브래드 구릉지";
    FLIGHTMAP_WETLANDS      = "저습지";
    FLIGHTMAP_ALTERAC       = "알터랙 산맥";
    FLIGHTMAP_ARATHI        = "아라시 고원";
    FLIGHTMAP_STRANGLETHORN = "가시덤불 골짜기";
    FLIGHTMAP_BADLANDS      = "황야의 땅";
    FLIGHTMAP_SORROWS       = "슬픔의 늪";
    FLIGHTMAP_HINTERLANDS   = "동부 내륙지";
    FLIGHTMAP_SEARINGGORGE  = "이글거리는 협곡";
    FLIGHTMAP_BLASTEDLANDS  = "저주받은 땅";
    FLIGHTMAP_BURNINGSTEPPE = "불타는 평원";
    FLIGHTMAP_WESTERNPLAGUE = "서부 역병지대";
    FLIGHTMAP_EASTERNPLAGUE = "동부 역병지대";
    FLIGHTMAP_DUROTAR       = "듀로타";
    FLIGHTMAP_MULGORE       = "멀고어";
    FLIGHTMAP_DARKSHORE     = "어둠의 해안";
    FLIGHTMAP_BARRENS       = "불모의 땅";
    FLIGHTMAP_STONETALON    = "돌발톱 산맥";
    FLIGHTMAP_ASHENVALE     = "잿빛 골짜기";
    FLIGHTMAP_1KNEEDLES     = "버섯구름 봉우리";
    FLIGHTMAP_DESOLACE      = "잊혀진 땅";
    FLIGHTMAP_DUSTWALLOW    = "먼지진흙 습지대";
    FLIGHTMAP_FERALAS       = "페랄라스";
    FLIGHTMAP_TANARIS       = "타나리스";
    FLIGHTMAP_AZSHARA       = "아즈샤라";
    FLIGHTMAP_FELWOOD       = "악령의 숲";
    FLIGHTMAP_UNGOROCRATER  = "운고로 분화구";
    FLIGHTMAP_SILITHUS      = "실리더스";
    FLIGHTMAP_WINTERSPRING  = "여명의 설원";
    FLIGHTMAP_TELDRASSIL    = "텔드랏실";
    FLIGHTMAP_DEADWINDPASS  = "죽음의 고개";
    FLIGHTMAP_ORGRIMMAR     = "오그리마";
    FLIGHTMAP_THUNDERBLUFF  = "썬더블러프";
    FLIGHTMAP_UNDERCITY     = "언더시티";
    FLIGHTMAP_IRONFORGE     = "아이언포지";
    FLIGHTMAP_STORMWIND     = "스톰윈드";
    FLIGHTMAP_DARNASSUS     = "다르나서스";

    -- General strings
    FLIGHTMAP_TIMING        = "(측정중)";
    FLIGHTMAP_LEVELS        = "레벨: %d - %d";
    FLIGHTMAP_NOFLIGHTS     = "알려진 경로 없음!";
    FLIGHTMAP_NOT_KNOWN     = "(알 수 없음)";
    FLIGHTMAP_NO_COST       = "무료";
    FLIGHTMAP_MONEY_GOLD    = "금";
    FLIGHTMAP_MONEY_SILVER  = "은";
    FLIGHTMAP_MONEY_COPPER  = "동";
    FLIGHTMAP_FLIGHTTIME    = "비행 시간: ";
    FLIGHTMAP_QUICKEST      = "가장 빠른 경로";
    FLIGHTMAP_TOTAL_TIME    = "총 소요 시간";
    FLIGHTMAP_VIA           = "경유 ";
    FLIGHTMAP_CONFIRM       = "%s(으)로 비행하시겠습니까?%s";
    FLIGHTMAP_CONFIRM_TIME  = " 이 비행은 소요 시간: ";

    -- Command strings
    FLIGHTMAP_RESET         = "다시 놓기";
    FLIGHTMAP_SHOWMAP       = "열려 있는";
    FLIGHTMAP_LOCKTIMES     = "잠그다";

    -- Help text
    FLIGHTMAP_TIMER_HELP    =
        "SHIFT 키를 누른 채 타이머 바를 드래그하여 위치를 조정하세요.";

    -- Option strings
    FLIGHTMAP_OPTIONS_CLOSE = "닫기";
    FLIGHTMAP_OPTIONS_TITLE = "FlightMap 옵션";
    FLIGHTMAP_OPTIONS = {};
    FLIGHTMAP_OPTIONS[1] = {   -- Option 1: flight path lines
        label = "비행 경로",
        option = "showPaths",
        tooltip = "비행 경로를 월드맵에 표시해줍니다.",
    };
    FLIGHTMAP_OPTIONS[2] = {   -- Option 2: extra POI buttons
        label = "비행장 아이콘 표시",
        option = "showPOIs",
        tooltip = "비행장의 위치를 아이콘으로 표시해줍니다.",
        children = {12, 13},
    };
    FLIGHTMAP_OPTIONS[12] = {   -- Option 12: continent POI icons
        label = "하늘길 대륜 아이콘 (대륜)",
        option = "showContinentPOIs",
        tooltip = "대륜 지도에 하늘길 대륜 아이콘을 표시합니다.",
    };
    FLIGHTMAP_OPTIONS[13] = {   -- Option 13: POI tooltips
        label = "하늘길 대륜 툴팁",
        option = "showPOITooltips",
        tooltip = "지도에서 하늘길 대륜 아이콘에 마우스를 올리면 툴팁을 표시합니다.",
    };
    FLIGHTMAP_OPTIONS[3] = {   -- Option 3: Unknown masters
        label = "모든 정보 보기",
        option = "showAllInfo",
        tooltip = "비행경로를 알 수 없어도 모두 보여줍니다.",
    };
    FLIGHTMAP_OPTIONS[4] = {   -- Option 4: Auto-Dismount
        label = "자동 하차",
        option = "autoDismount",
        tooltip = "비행 관리인과 대화할 때 자동으로 탈것에서 내립니다.",
    };
    FLIGHTMAP_OPTIONS[5] = {   -- Option 5: flight timers
        label = "비행 시간 타이머",
        option = "useTimer",
        tooltip = "비행 시간을 잽니다.",
    };
    FLIGHTMAP_OPTIONS[6] = {   -- Option 6: Show flight destinations
        label = "목적지 표시",
        option = "showDestinations",
        tooltip = "툴팁에 비행 목적지를 표시합니다.",
        children = {7, 8, 9},
    };
    FLIGHTMAP_OPTIONS[7] = {   -- Option 7: Show multi-hop destinations
        label = "경유 목적지 포함",
        option = "showMultiHop",
        tooltip = "툴팁에 경유 목적지를 표시합니다.",
    };
    FLIGHTMAP_OPTIONS[8] = {   -- Option 8: Show flight times
        label = "비행 시간 표시",
        option = "showTimes",
        tooltip = "비행 시간을 툴팁에 보여줍니다.",
    };
    FLIGHTMAP_OPTIONS[9] = {   -- Option 9: Show flight costs
        label = "비행료 표시",
        option = "showCosts",
        tooltip = "비행료를 툴팁에 보여줍니다.",
    };
    FLIGHTMAP_OPTIONS[10] = {   -- Option 10: Taxi window extras
        label = "전체 비행 지도",
        option = "fullTaxiMap",
        tooltip = "비행 창 지도에서 도달할 수 없는 노드를 표시합니다.",
    };
    FLIGHTMAP_OPTIONS[11] = {   -- Option 11: Confirm flight destinations
        label = "비행 확인",
        option = "confirmFlights",
        tooltip = "비행 전에 확인을 요청합니다.",
    };
    FLIGHTMAP_OPTIONS[14] = {   -- Option 14: zone tooltip
        label = "지역 툴팁 표시",
        option = "showZoneTooltip",
        tooltip = "대륙 지도에서 지역 툴팁을 표시합니다.",
		children = {15},
    };
    FLIGHTMAP_OPTIONS[15] = {   -- Option 15: zone level ranges
        label = "지역 레벨 범위 표시",
        option = "showLevelRanges",
        tooltip = "각 지역의 권장 레벨 범위를 표시합니다.",
    };
    FLIGHTMAP_OPTIONS[16] = {   -- Option 16: UnitXP notify taskbar
        label = "알림: 작업 표시줄 아이콘",
        option = "notifyTaskbar",
        tooltip = "도착 시 작업 표시줄 아이콘을 깜빡입니다.",
    };
    FLIGHTMAP_OPTIONS[17] = {   -- Option 17: UnitXP notify sound
        label = "알림: 시스템 소리",
        option = "notifySound",
        tooltip = "도착 시 시스템 소리를 재생합니다.",
    };
    FLIGHTMAP_OPTIONS[18] = {   -- Option 18: Minimap button
        label = "미니맵 버튼",
        option = "showMinimapButton",
        tooltip = "미니맵에 FlightMap 버튼을 표시합니다.",
    };
    FLIGHTMAP_OPTIONS[19] = {   -- Option 19: Lock flight times
        label = "비행 시간 잠금",
        option = "lockFlightTimes",
        tooltip = "애드온이 새로운 또는 다른 비행 데이터를 저장 변수에 기록하지 못하도록 합니다.",
    };

    FLIGHTMAP_TOOLTIP_FONT_SIZE             = "툴팁 글꼴 크기";
    FLIGHTMAP_TOOLTIP_FONT_SIZE_TIP         = "FlightMap 툴팁 텍스트의 글꼴 크기를 조정합니다.";
    FLIGHTMAP_MINIMAP_TIP1                  = "마우스 왼쪽 버튼을 클릭하여 FlightMap 메뉴를 엽니다.";
    FLIGHTMAP_MINIMAP_TIP2                  = "마우스 오른쪽 버튼을 길게 눌러 미니맵 버튼을 이동하세요.";
    FLIGHTMAP_MINIMAP_TIP3                  = "Ctrl 키를 누른 상태에서 마우스 왼쪽 버튼을 클릭하여 비행 경로 지도를 엽니다.";
    FLIGHTMAP_MINIMAP_TIP4                  = "Shift 키를 누른 상태에서 마우스 왼쪽 버튼을 클릭하여 타이머 바 위치를 초기화합니다.";

    -- These constants determine how "Town (Zone)" strings look.
    -- SEP_STRING is what separates Town from Zone.  SEP_POSTAMBLE
    -- is anything that is after Zone.
    FLIGHTMAP_SEP_STRING    = " (";
    FLIGHTMAP_SEP_POSTAMBLE = ")";
end
