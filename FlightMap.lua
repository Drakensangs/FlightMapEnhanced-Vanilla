-- FlightMap - AddOn to show inbound and outbound flightpaths from a given
--             zone on the World Map.  Additionally shows flight costs and
--             zone level ranges.
-- Copyright (c) 2005 Byron Ellacott (Dhask of Uther)
--
-- An unlimited license to use, reproduce and copy this work is granted, on
-- the condition that the licensee accepts all responsibility and liability
-- for any damage that may arise from the use of this AddOn.

-- Version number
FLIGHTMAP_VERSION   = "1.12-1";

-- Maximum lines to draw at once
FLIGHTMAP_MAX_PATHS = 15;

-- Size and names for path texture files
FLIGHTMAP_LINE_SIZE = 256;
FLIGHTMAP_TEX_UP    = "Interface\\AddOns\\FlightMap\\FlightMapUp";
FLIGHTMAP_TEX_DOWN  = "Interface\\AddOns\\FlightMap\\FlightMapDown";

-- Maximum POI buttons defined
FLIGHTMAP_MAX_POIS  = 15;

-- How many pixels is too close to another POI?
FLIGHTMAP_CLOSE     = 16;
FLIGHTMAP_CLOSE_SQ  = FLIGHTMAP_CLOSE * FLIGHTMAP_CLOSE; -- Pre-compute for distance checks

-- Textures for flightmaster POI icons
FLIGHTMAP_POI_KNOWN = "Interface\\TaxiFrame\\UI-Taxi-Icon-Green";
FLIGHTMAP_POI_OTHER = "Interface\\TaxiFrame\\UI-Taxi-Icon-Gray";

local lTYPE_HORDE     = FLIGHTMAP_HORDE;
local lTYPE_ALLIANCE  = FLIGHTMAP_ALLIANCE;
local lTYPE_CONTESTED = FLIGHTMAP_CONTESTED;

-- According to http://www.worldofwarcraft.com/ at any rate...
FLIGHTMAP_RANGES   = {
    [FLIGHTMAP_ELWYNN]        = { 1, 10, lTYPE_ALLIANCE},
    [FLIGHTMAP_DUNMOROGH]     = { 1, 10, lTYPE_ALLIANCE},
    [FLIGHTMAP_TIRISFAL]      = { 1, 10, lTYPE_HORDE},
    [FLIGHTMAP_LOCHMODAN]     = {10, 20, lTYPE_ALLIANCE},
    [FLIGHTMAP_SILVERPINE]    = {10, 20, lTYPE_HORDE},
    [FLIGHTMAP_WESTFALL]      = {10, 20, lTYPE_ALLIANCE},
    [FLIGHTMAP_REDRIDGE]      = {15, 25, lTYPE_CONTESTED},
    [FLIGHTMAP_DUSKWOOD]      = {18, 30, lTYPE_CONTESTED},
    [FLIGHTMAP_HILLSBRAD]     = {20, 30, lTYPE_CONTESTED},
    [FLIGHTMAP_WETLANDS]      = {20, 30, lTYPE_CONTESTED},
    [FLIGHTMAP_ALTERAC]       = {30, 40, lTYPE_CONTESTED},
    [FLIGHTMAP_ARATHI]        = {30, 40, lTYPE_CONTESTED},
    [FLIGHTMAP_STRANGLETHORN] = {30, 45, lTYPE_CONTESTED},
    [FLIGHTMAP_BADLANDS]      = {35, 45, lTYPE_CONTESTED},
    [FLIGHTMAP_SORROWS]       = {35, 45, lTYPE_CONTESTED},
    [FLIGHTMAP_HINTERLANDS]   = {40, 50, lTYPE_CONTESTED},
    [FLIGHTMAP_SEARINGGORGE]  = {43, 50, lTYPE_CONTESTED},
    [FLIGHTMAP_BLASTEDLANDS]  = {45, 55, lTYPE_CONTESTED},
    [FLIGHTMAP_BURNINGSTEPPE] = {50, 58, lTYPE_CONTESTED},
    [FLIGHTMAP_WESTERNPLAGUE] = {51, 58, lTYPE_CONTESTED},
    [FLIGHTMAP_EASTERNPLAGUE] = {53, 60, lTYPE_CONTESTED},
    [FLIGHTMAP_DUROTAR]       = { 1, 10, lTYPE_HORDE},
    [FLIGHTMAP_MULGORE]       = { 1, 10, lTYPE_HORDE},
    [FLIGHTMAP_DARKSHORE]     = {10, 20, lTYPE_ALLIANCE},
    [FLIGHTMAP_BARRENS]       = {10, 25, lTYPE_HORDE},
    [FLIGHTMAP_STONETALON]    = {15, 27, lTYPE_CONTESTED},
    [FLIGHTMAP_ASHENVALE]     = {18, 30, lTYPE_CONTESTED},
    [FLIGHTMAP_1KNEEDLES]     = {25, 35, lTYPE_CONTESTED},
    [FLIGHTMAP_DESOLACE]      = {30, 40, lTYPE_CONTESTED},
    [FLIGHTMAP_DUSTWALLOW]    = {35, 45, lTYPE_CONTESTED},
    [FLIGHTMAP_FERALAS]       = {40, 50, lTYPE_CONTESTED},
    [FLIGHTMAP_TANARIS]       = {40, 50, lTYPE_CONTESTED},
    [FLIGHTMAP_AZSHARA]       = {45, 55, lTYPE_CONTESTED},
    [FLIGHTMAP_FELWOOD]       = {48, 55, lTYPE_CONTESTED},
    [FLIGHTMAP_UNGOROCRATER]  = {48, 55, lTYPE_CONTESTED},
    [FLIGHTMAP_SILITHUS]      = {55, 60, lTYPE_CONTESTED},
    [FLIGHTMAP_WINTERSPRING]  = {55, 60, lTYPE_CONTESTED},
    [FLIGHTMAP_TELDRASSIL]    = { 1, 10, lTYPE_ALLIANCE},
    [FLIGHTMAP_MOONGLADE]     = { 1, 60, lTYPE_CONTESTED},
    [FLIGHTMAP_DEADWINDPASS]  = {55, 60, lTYPE_CONTESTED},
};

-- Colours for zones
FLIGHTMAP_COLORS = {
    Unknown   = { r = 0.8, g = 0.8, b = 0.8 },
    Hostile   = { r = 0.9, g = 0.2, b = 0.2 },
    Friendly  = { r = 0.2, g = 0.9, b = 0.2 },
    Contested = { r = 0.8, g = 0.6, b = 0.4 },
};

-- Auto dismount for these buffs
FLIGHTMAP_DISMOUNTS = {
  ["Interface\\Icons\\Ability_Mount_BlackDireWolf"] = 1,
  ["Interface\\Icons\\Ability_Mount_BlackPanther"] = 1,
  ["Interface\\Icons\\Ability_Mount_Charger"] = 1,
  ["Interface\\Icons\\Ability_Mount_Dreadsteed"] = 1,
  ["Interface\\Icons\\Ability_Mount_JungleTiger"] = 1,
  ["Interface\\Icons\\Ability_Mount_Kodo_01"] = 1,
  ["Interface\\Icons\\Ability_Mount_Kodo_02"] = 1,
  ["Interface\\Icons\\Ability_Mount_Kodo_03"] = 1,
  ["Interface\\Icons\\INV_Misc_Horn_01"] = 1,
  ["Interface\\Icons\\Ability_Mount_MountainRam"] = 1,
  ["Interface\\Icons\\Spell_Nature_Swiftness"] = 1,
  ["Interface\\Icons\\Ability_Mount_NightmareHorse"] = 1,
  ["Interface\\Icons\\Ability_Mount_PinkTiger"] = 1,
  ["Interface\\Icons\\Ability_Mount_Raptor"] = 1,
  ["Interface\\Icons\\Ability_Mount_RidingHorse"] = 1,
  ["Interface\\Icons\\Ability_Mount_Undeadhorse"] = 1,
  ["Interface\\Icons\\Ability_Mount_WhiteDireWolf"] = 1,
  ["Interface\\Icons\\Ability_Mount_WhiteTiger"] = 1,
}

-- Cache for faction lookup (avoid repeated UnitFactionGroup calls)
local lFactionCache = nil;
local lFactionCacheTime = 0;

-- Cache for frame references (avoid repeated getglobal calls)
local lPOIButtonCache = {};
local lPathFrameCache = {};

------------------ Data access functions ------------------

local function lStripPoint(map, point)
    for k, v in map do
        if v.Costs then 
            v.Costs[point] = nil; 
        end
        if v.Flights then 
            v.Flights[point] = nil; 
        end
    end
    for k, v in FlightMap.Knowledge do
        v[point] = nil;
    end
    map[point] = nil;
end

-- Default option settings
FLIGHTMAP_DEFAULT_OPTS = {
    showPaths = true,
    showPOIs = true,
    showCosts = true,
    showTimes = true,
    showDestinations = true,
    showAllInfo = false,
    showMultiHop = true,
    lockFlightTimes = false,
    autoDismount = true,
    fontSize = 12,
    showLevelRanges = true,
};

local function lSetDefaultData()
    -- Create an empty knowledge record
    if not FlightMap["Knowledge"] then
        FlightMap.Knowledge = {};
    end

    -- Default option settings
    if (not FlightMap["Opts"]) then
        FlightMap["Opts"] = FLIGHTMAP_DEFAULT_OPTS;
    end

    -- Any options that don't have a value at all should be defaulted
    for k, v in pairs(FLIGHTMAP_DEFAULT_OPTS) do
        if FlightMap.Opts[k] == nil then
            FlightMap.Opts[k] = v;
        end
    end

    -- Patch 1.8: Remove any references to Valor's Rest
    lStripPoint(FlightMap[FLIGHTMAP_HORDE] or {}, "1:461:226");
    lStripPoint(FlightMap[FLIGHTMAP_ALLIANCE] or {}, "1:463:223");

    -- Patch 1.12: Remove any references to Alliance's misplaced Moonglade
    lStripPoint(FlightMap[FLIGHTMAP_ALLIANCE] or {}, "1:552:793");

    -- Revision 1.8-2: Delete pre-1.7 data
    FlightMap.Locs = nil;
    FlightMap.Times = nil;
end

-- Learn about the currently open taxi map
local function lLearnTaxiNode()
    local map = FlightMapUtil.getFlightMap();

    local oldCont, oldZone = GetCurrentMapContinent(),
                             GetCurrentMapZone();

    SetMapToCurrentZone();

    local thisCont = GetCurrentMapContinent();

    local thisNode;
    local destinations = {};
    local numNodes = NumTaxiNodes();
    for index = 1, numNodes, 1 do
        local tType = TaxiNodeGetType(index);
        if (tType == "CURRENT") then
            thisNode = index;
        elseif (tType == "REACHABLE") then
            local mx, my = TaxiNodePosition(index);
            local destName = FlightMapUtil.makeNodeName(thisCont, mx, my);

            destinations[destName] = index;

            FlightMapUtil.knownNode(destName, true);

            if not map[destName] then
                map[destName] = {
                    Name      = "Fix me",
                    Zone      = "Unknown!",
                    Continent = -1,
                    Flights   = {},
                    Costs     = {},
                    Routes    = {},
                    Location  = {
                        Taxi      = { x = mx, y = my },
                        Zone      = { x = 0, y = 0 },
                        Continent = { x = 0, y = 0 },
                    },
                };
            end

            if map[destName] then
                map[destName].Name = TaxiNodeName(index);
            end
        end
    end

    if (thisNode) then
        local mx, my = TaxiNodePosition(thisNode);
        local thisName = FlightMapUtil.makeNodeName(thisCont, mx, my);
        local zoneName = FlightMapUtil.getZoneName();
        local zx, zy = GetPlayerMapPosition("player");
        SetMapZoom(thisCont, nil);
        local cx, cy = GetPlayerMapPosition("player");

        FlightMapUtil.knownNode(thisName, true);

        if not map[thisName] then
            map[thisName] = {};
        end
        if not map[thisName].Flights then
            map[thisName].Flights = {};
        end
        if not map[thisName].Costs then
            map[thisName].Costs = {};
        end
        if not map[thisName].Routes then
            map[thisName].Routes = {};
        end

        map[thisName].Name = TaxiNodeName(thisNode);
        map[thisName].Zone = zoneName;
        map[thisName].Continent = thisCont;
        map[thisName].Location = {
            Zone = { x = zx, y = zy },
            Continent = { x = cx, y = cy },
            Taxi = { x = mx, y = my },
        };

        for k,v in pairs(destinations) do
            map[thisName].Costs[k] = TaxiNodeCost(v);

            local routes = GetNumRoutes(v);
            if routes > 1 then
                local totalTime = 0;
                local prevSpot = thisName;
                local newRoute = {};
                for r = 1, routes do
                    local dest = FlightMapUtil.makeNodeName(thisCont,
                            TaxiGetDestX(v, r), TaxiGetDestY(v, r));
                    table.insert(newRoute, dest);

                    if map[prevSpot] and map[prevSpot].Flights[dest]
                        and map[prevSpot].Flights[dest] > 0
                        and totalTime then
                        totalTime = totalTime + map[prevSpot].Flights[dest];
                    else
                        totalTime = nil;
                    end

                    prevSpot = dest;
                end

                local oldRoute = map[thisName].Routes[k];
                local isNewRoute = not oldRoute
                    or table.getn(oldRoute) ~= table.getn(newRoute)
                    or table.foreachi(newRoute, function(idx)
                        return newRoute[idx] ~= oldRoute[idx];
                    end);

                if isNewRoute or map[thisName].Flights[k] == 0 then
                    map[thisName].Flights[k] = totalTime;
                    map[thisName].Routes[k] = newRoute;
                end
            else
                map[thisName].Routes[k] = nil;
            end

            if not map[thisName].Flights[k] then
                map[thisName].Flights[k] = 0;
            end
        end
    end

    SetMapZoom(oldCont, oldZone);
end

------------------ Miscellaneous utility ------------------

-- Cached faction lookup with time decay (60 second cache)
local function lGetPlayerFaction()
    local currentTime = GetTime();
    if lFactionCache and (currentTime - lFactionCacheTime) < 60 then
        return lFactionCache;
    end
    lFactionCache = UnitFactionGroup("player");
    lFactionCacheTime = currentTime;
    return lFactionCache;
end

local function lAutoDismount()
    if not FlightMap.Opts.autoDismount then return; end

    for i = 0, 15, 1 do
        local id, isAura = GetPlayerBuff(i, "HELPFUL");
        if isAura and FLIGHTMAP_DISMOUNTS[GetPlayerBuffTexture(id)] then
            CancelPlayerBuff(id);
        end
    end
end

------------------ Map drawing functions ------------------

local function lFormatExtra(cost, secs)
    local result = "";
    if cost ~= nil and FlightMap.Opts.showCosts then
        local dosh = FlightMapUtil.formatMoney(cost);
        if cost == 0 then dosh = FLIGHTMAP_NO_COST; end
        result = dosh;
    end
    if secs ~= nil and FlightMap.Opts.showTimes then
        local durn = FlightMapUtil.formatTime(secs);
        if result ~= "" then
            result = result .. " " .. durn;
        else
            result = durn;
        end
    end
    return result;
end

-- Add node name and location into the given tooltip
local function lAddFlightsForNode(tooltip, node, prefix, source)
    if not prefix then prefix = ""; end

    local map = FlightMapUtil.getFlightMap();
    local data = map[node];
    if not data then return 0; end
    if not data.Costs then data.Costs = {}; end

    local name = data.Name;
    local locn = "";
    if data.Location.Zone then
        locn = string.format("%d, %d", data.Location.Zone.x * 100,
                data.Location.Zone.y * 100);
    end

    if FlightMapUtil.knownNode(node) then
        tooltip:AddDoubleLine(prefix .. name, locn);
    else
        local r = NORMAL_FONT_COLOR.r * 0.7;
        local g = NORMAL_FONT_COLOR.g * 0.7;
        local b = NORMAL_FONT_COLOR.b * 0.7;
        tooltip:AddDoubleLine(prefix .. name, locn, r, g, b, r, g, b);
    end

    prefix = prefix .. " ";
    if source and map[source] then
        if map[source].Flights[node] then
          local durn = FlightMapUtil.formatTime(map[source].Flights[node]);
          GameTooltip:AddLine(prefix .. FLIGHTMAP_FLIGHTTIME .. durn, 1, 1, 1);
        end
        if map[source].Routes[node] then
            local src = map[source];
            for i = 1, table.getn(src.Routes[node]) - 1 do
                local hop = src.Routes[node][i];
                GameTooltip:AddLine(prefix .. FLIGHTMAP_VIA .. map[hop].Name,
                        0.7, 0.7, 0.7);
            end
        end
    end

    if not source and FlightMap.Opts.showDestinations then
        for dest, secs in data.Flights do
            local islocal = (not data.Routes or not data.Routes[dest]);
            local destData = map[dest];
            if destData and (islocal or FlightMap.Opts.showMultiHop) then
                local name, _ = FlightMapUtil.getNameAndZone(destData.Name);
                local cost = data.Costs[dest];
                local extra = lFormatExtra(cost, secs);
                if FlightMapUtil.knownNode(dest) then
                    tooltip:AddDoubleLine(prefix .. name, extra,
                        1, 1, 1, 1, 1, 1);
                elseif FlightMap.Opts.showAllInfo then
                    tooltip:AddDoubleLine(prefix .. name, extra,
                        0.7, 0.7, 0.7, 0.7, 0.7, 0.7);
                end
            end
         end
    end

    return 1;
end
FlightMapUtil.addFlightsForNode = lAddFlightsForNode;

-- Update the flight tooltip for a zone
local function lUpdateTooltip(zoneName)
    if not zoneName or zoneName == "" then
        FlightMapTooltip:Hide();
        return;
    end

    FlightMapTooltip:SetOwner(this, "ANCHOR_LEFT");

    local title = FLIGHTMAP_COLORS.Unknown;
    local levels = nil;
    if (FLIGHTMAP_RANGES[zoneName]) then
        local faction = lGetPlayerFaction();
        local min = FLIGHTMAP_RANGES[zoneName][1];
        local max = FLIGHTMAP_RANGES[zoneName][2];
        local side = FLIGHTMAP_RANGES[zoneName][3];
        if (side == lTYPE_CONTESTED) then
            title = FLIGHTMAP_COLORS.Contested;
        else
            if (faction == side) then
                title = FLIGHTMAP_COLORS.Friendly;
            else
                title = FLIGHTMAP_COLORS.Hostile;
            end
        end
        levels = string.format(FLIGHTMAP_LEVELS, min, max);
    end

    FlightMapTooltip:SetText(zoneName, title.r, title.g, title.b);
    if levels and FlightMap.Opts.showLevelRanges then
        FlightMapTooltip:AddLine(levels, title.r, title.g, title.b);
    end

    local nodes = FlightMapUtil.getNodesInZone(zoneName, true);

    local flights = 0;
    for node, data in nodes do
        if FlightMapUtil.knownNode(node) or FlightMap.Opts.showAllInfo then
            flights = flights + lAddFlightsForNode(FlightMapTooltip, node, "");
        end
    end

    FlightMapTooltip:SetBackdropColor(0, 0, 0, 0.5);
    FlightMapTooltip:SetBackdropBorderColor(0, 0, 0, 0);
    FlightMapTooltip:ClearAllPoints();
    FlightMapTooltip:SetPoint("BOTTOMLEFT", "WorldMapDetailFrame",
            "BOTTOMLEFT", 0, 0);

    if flights > 0 or (levels and FlightMap.Opts.showLevelRanges) then
        FlightMapTooltip:Show();
    else
        FlightMapTooltip:Hide();
    end

    FlightMapTooltip:ClearAllPoints();
    FlightMapTooltip:SetPoint("BOTTOMLEFT", WorldMapDetailFrame);
end

-- Returns true iff an existing world map POI icon is very close to the given coordinates
local function lCloseToExistingPOI(x, y)
    local closeDistSq = FLIGHTMAP_CLOSE_SQ;
    for i = 1, NUM_WORLDMAP_POIS, 1 do
        local button = getglobal("WorldMapFramePOI" .. i);
        if button:IsVisible() then
            local _, _, index, _, _ = GetMapLandmarkInfo(i);
            if index ~= 15 then
                local px, py = button:GetCenter();
                px = px - WorldMapDetailFrame:GetLeft();
                py = py - WorldMapDetailFrame:GetBottom();
                local dx = px - x;
                local dy = py - y;
                if (dx * dx + dy * dy) < closeDistSq then
                    return true;
                end
            end
        end
    end
    return false;
end

-- Try showing a POI node
local function lShowNodePOI(node, data, space, num)
    if not data.Location[space] then return false; end
    if num > FLIGHTMAP_MAX_POIS then return false; end

    local x = data.Location[space].x;
    local y = data.Location[space].y;

    x = x * WorldMapDetailFrame:GetWidth();
    y = (1 - y) * WorldMapDetailFrame:GetHeight();

    if lCloseToExistingPOI(x, y) then return false; end

    local name, _ = FlightMapUtil.getNameAndZone(data.Name);
    
    local button = lPOIButtonCache[num];
    if not button then
        button = getglobal("FlightMapPOI" .. num);
        lPOIButtonCache[num] = button;
    end

    if not FlightMapUtil.knownNode(node) then
        if not FlightMap.Opts.showAllInfo then
            return false;
        end
        button:SetNormalTexture(FLIGHTMAP_POI_OTHER);
    else
        button:SetNormalTexture(FLIGHTMAP_POI_KNOWN);
    end

    button.name = name;
    button.data = data;
    button.node = node;
    button:SetPoint("CENTER", "WorldMapDetailFrame",
            "BOTTOMLEFT", x, y);
    button:Show();

    return true;
end

-- Show locations of flight masters for either continent or zone level maps
local function lUpdateFlightPOIs(zoneName)
    local continent = GetCurrentMapContinent();
    local mapZone = GetCurrentMapZone();
    local POI = 1;

    if mapZone ~= 0 and FlightMap.Opts.showPOIs then
        local nodes = FlightMapUtil.getNodesInZone(zoneName, false);
        for node, data in nodes do
            if lShowNodePOI(node, data, "Zone", POI) then
                POI = POI + 1;
            end
        end
    elseif continent ~= 0 and FlightMap.Opts.showPOIs then
        local map = FlightMapUtil.getFlightMap();
        for node, data in map do
            if data.Continent == continent then
                if lShowNodePOI(node, data, "Continent", POI) then
                    POI = POI + 1;
                end
            end
        end
    end

    for i = POI, FLIGHTMAP_MAX_POIS, 1 do
        local button = lPOIButtonCache[i];
        if not button then
            button = getglobal("FlightMapPOI" .. i);
            lPOIButtonCache[i] = button;
        end
        button:Hide();
    end
end

-- Draw a line from one flight node to another
local function lDrawFlightLine(from, to, num)
    if num > FLIGHTMAP_MAX_PATHS then return false; end

    local map = FlightMapUtil.getFlightMap();

    if not map[from] or not map[to] then return false; end

    local src = map[from].Location.Continent;
    local dst = map[to].Location.Continent;

    if not src or not dst then return false; end

    local tex = lPathFrameCache[num];
    if not tex then
        tex = getglobal("FlightMapPath" .. num);
        lPathFrameCache[num] = tex;
    end

    return FlightMapUtil.drawLine(WorldMapDetailFrame, tex,
            src.x, src.y, dst.x, dst.y);
end

-- Fill in flight map lines
local function lDrawFlightLines(zoneName)
    local lineNum = 1;

    if zoneName and FlightMap.Opts.showPaths then
        local nodes = FlightMapUtil.getNodesInZone(zoneName, true);
        for node, data in nodes do
            if FlightMap.Opts.showAllInfo or FlightMapUtil.knownNode(node) then
                for dest, duration in data.Flights do
                    if not (data.Routes and data.Routes[dest])
                    and (FlightMap.Opts.showAllInfo
                    or FlightMapUtil.knownNode(dest)) then
                        if lDrawFlightLine(node, dest, lineNum) then
                            lineNum = lineNum + 1;
                        end
                    end
                end
            end
        end
    end

    for i = lineNum, FLIGHTMAP_MAX_PATHS, 1 do
        local tex = lPathFrameCache[i];
        if not tex then
            tex = getglobal("FlightMapPath" .. i);
            lPathFrameCache[i] = tex;
        end
        tex:Hide();
    end
end

-- Last drawn info for tooltip
lFM_CurrentZone = nil;
lFM_CurrentArea = nil;
local lFM_OldUpdate = function() end;

-- Replacement function to draw all the extra goodies of FlightMap
function FlightMap_WorldMapButton_OnUpdate(arg1)
    lFM_OldUpdate(arg1);
    local areaName = WorldMapFrame.areaName;
    local zoneNum = GetCurrentMapZone();

    if FLIGHTMAP_SUBZONES[areaName] then
        areaName = FLIGHTMAP_SUBZONES[areaName];
    end

    if zoneNum == lFM_CurrentZone and areaName == lFM_CurrentArea then
        return;
    end

    lFM_CurrentZone = zoneNum;
    lFM_CurrentArea = areaName;

    if zoneNum == 0 then
        lUpdateTooltip(areaName);
        lUpdateFlightPOIs(areaName);
        lDrawFlightLines(areaName);
    else
        lUpdateFlightPOIs(FlightMapUtil.getZoneName());
        lUpdateTooltip(nil);
        lDrawFlightLines(nil);
    end
end

function FlightMapPOIButton_OnEnter()
    local x, y = this:GetCenter();
    local parentX, parentY = WorldMapDetailFrame:GetCenter();
    if (x > parentX) then
        WorldMapTooltip:SetOwner(this, "ANCHOR_LEFT");
    else
        WorldMapTooltip:SetOwner(this, "ANCHOR_RIGHT");
    end
    lAddFlightsForNode(WorldMapTooltip, this.node, "");
    WorldMapTooltip:Show();
end

---------------- Initialization functions -----------------

-- /flightmap handler
function FlightMap_OnSlashCmd(args)
    if args == FLIGHTMAP_RESET then 
        FlightMapTimesFrame:ClearAllPoints();
        FlightMapTimesFrame:SetPoint("TOP", PVPArenaTextString, "BOTTOM");
    elseif args == FLIGHTMAP_SHOWMAP then
        FlightMapTaxi_ShowContinent();
    elseif args == FLIGHTMAP_LOCKTIMES then
        FlightMap.Opts.lockFlightTimes = not FlightMap.Opts.lockFlightTimes;
        DEFAULT_CHAT_FRAME:AddMessage(
            FLIGHTMAP_TIMESLOCKED[FlightMap.Opts.lockFlightTimes],
            1.0, 1.0, 1.0);
    elseif args == FLIGHTMAP_GETHELP then
        for cmd, desc in FLIGHTMAP_SUBCOMMANDS do
            DEFAULT_CHAT_FRAME:AddMessage("|cffcc9010" .. cmd .. "|r " .. desc,
                1.0, 1.0, 1.0);
        end
    elseif (FlightMapOptionsFrame:IsVisible()) then
        HideUIPanel(FlightMapOptionsFrame);
    else
        ShowUIPanel(FlightMapOptionsFrame);
    end
end

function FlightMap_OnLoad()
    this:RegisterEvent("TAXIMAP_OPENED");

    if (Sea) then
        Sea.util.hook("WorldMapButton_OnUpdate",
                      "FlightMap_WorldMapButton_OnUpdate",
                      "after");
    else
        lFM_OldUpdate = WorldMapButton_OnUpdate;
        WorldMapButton_OnUpdate = FlightMap_WorldMapButton_OnUpdate;
    end

    SLASH_FLIGHTMAP1 = "/fmap";
    SLASH_FLIGHTMAP2 = "/flightmap";
    SlashCmdList["FLIGHTMAP"] = FlightMap_OnSlashCmd;

    this:RegisterEvent("VARIABLES_LOADED");

    UIPanelWindows["FlightMapOptionsFrame"] = {
        area = "center",
        pushable = 0,
    };
end

function FlightMap_OnEvent(event)
    if (event == "TAXIMAP_OPENED") then
        lAutoDismount();
        lLearnTaxiNode();
    elseif (event == "VARIABLES_LOADED") then
        lSetDefaultData();
		
		FlightMap_UpdateTooltipFont();

        if (myAddOnsFrame_Register) then
            myAddOnsFrame_Register({
                name         = "FlightMap",
                version      = FLIGHTMAP_VERSION,
                releaseDate  = FLIGHTMAP_RELEASE,
                author       = "Dhask",
                category     = MYADDONS_CATEGORY_MAP,
                optionsframe = "FlightMapOptionsFrame",
            });
        end
    end
end

----------------- Options panel functions -----------------

function FlightMapOptionsFrame_OnShow()
    FlightMapOptionsFrameClose:SetText(FLIGHTMAP_OPTIONS_CLOSE);
    FlightMapOptionsFrameTitle:SetText(FLIGHTMAP_OPTIONS_TITLE);

    local base = "FlightMapOptionsFrame"
    for optid, option in pairs(FLIGHTMAP_OPTIONS or {}) do
        local name = base .. "Opt" .. optid;
        local button = getglobal(name);
        local label = getglobal(name .. "Text");
        OptionsFrame_EnableCheckBox(button, 1, FlightMap.Opts[option.option]);

        label:SetText(option.label);
        button.tooltipText = option.tooltip;
        button.option = option.option;
        button.children = option.children or {};
    end

    for optid, option in pairs(FLIGHTMAP_OPTIONS or {}) do
        for _, child in option.children or {} do
            local other = getglobal(base .. "Opt" .. child);
            if other then
                if FlightMap.Opts[option.option] then
                    OptionsFrame_EnableCheckBox(other, 1,
                        FlightMap.Opts[FLIGHTMAP_OPTIONS[child].option]);
                else
                    OptionsFrame_DisableCheckBox(other);
                end
            end
        end
    end

    if not FlightMapLevelRangesCheckButton then
        local button = CreateFrame("CheckButton", "FlightMapLevelRangesCheckButton", FlightMapOptionsFrame, "OptionsCheckButtonTemplate");
        button:SetPoint("TOPLEFT", FlightMapOptionsFrameClose, "BOTTOMLEFT", 35, 109);
        button:SetChecked(FlightMap.Opts.showLevelRanges);
        button.option = "showLevelRanges";
        button.children = {};
        button:SetScript("OnClick", FlightMapOptionsCheckButton_OnClick);
        
        local label = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
        label:SetPoint("LEFT", button, "RIGHT", 2, 0);
        label:SetText("Show Level Ranges");
        button.tooltipText = "Display the recommended level range for each zone";
        
        button:SetScript("OnEnter", function()
            if (button.tooltipText) then
                GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
                GameTooltip:AddLine(button.tooltipText, 1, 1, 1);
                GameTooltip:Show();
            end
        end);
        
        button:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);
    else
        FlightMapLevelRangesCheckButton:SetChecked(FlightMap.Opts.showLevelRanges);
    end

    if not FlightMapFontSizeSlider then
        CreateFrame("Slider", "FlightMapFontSizeSlider", FlightMapOptionsFrame, "OptionsSliderTemplate");
        FlightMapFontSizeSlider:SetWidth(220);
        FlightMapFontSizeSlider:SetHeight(16);
        FlightMapFontSizeSlider:SetOrientation("HORIZONTAL");
        FlightMapFontSizeSlider:SetPoint("TOP", FlightMapOptionsFrameClose, "BOTTOM", 0, 55);

        FlightMapFontSizeSlider:SetMinMaxValues(8, 20);
        FlightMapFontSizeSlider:SetValueStep(1);

        local txt = getglobal("FlightMapFontSizeSliderText");
        if txt then txt:SetText("Tooltip Font Size"); end
        local low = getglobal("FlightMapFontSizeSliderLow");
        local high = getglobal("FlightMapFontSizeSliderHigh");
		if low then low:SetText("8"); end
		if high then high:SetText("20"); end

        FlightMapFontSizeSlider.tooltipText = "Adjusts the font size of the FlightMap tooltip text.";
        
        FlightMapFontSizeSlider:SetScript("OnEnter", function()
            if FlightMapFontSizeSlider.tooltipText then
                GameTooltip:SetOwner(FlightMapFontSizeSlider, "ANCHOR_RIGHT");
                GameTooltip:AddLine(FlightMapFontSizeSlider.tooltipText, 1, 1, 1);
                GameTooltip:Show();
            end
        end);
        
        FlightMapFontSizeSlider:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);
		
		local function FlightMapFontSizeSlider_Internal_OnValueChanged(maybeSelf, maybeValue)
		    local frame = maybeSelf or this; 
			if not frame then
			    frame = getglobal("FlightMapFontSizeSlider");
			end
			if not frame then return; end
			
			local value = maybeValue;
			if not value then
			    if type(maybeSelf) == "number" then
				    value = maybeSelf;
				else
				    value = frame:GetValue();
				end
			end
			
			local val = tonumber(value) or frame:GetValue() or 12;
			val = math.floor(val +0.5);
			
			if not FlightMap then FlightMap = {}; end
			if not FlightMap.Opts then FlightMap.Opts = {}; end
			FlightMap.Opts.fontSize = val;
			
			if FlightMap_UpdateTooltipFont then
			    FlightMap_UpdateTooltipFont();
			end
		end
		
        FlightMapFontSizeSlider:SetScript("OnValueChanged", FlightMapFontSizeSlider_Internal_OnValueChanged);
		
    end

    FlightMapFontSizeSlider:SetValue( (FlightMap and FlightMap.Opts and FlightMap.Opts.fontSize) or 12 );
	if FlightMap_UpdateTooltipFont then FlightMap_UpdateTooltipFont(); end
end

function FlightMapOptionsFrame_OnHide()
    if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
        ShowUIPanel(myAddOnsFrame);
    end
end

function FlightMapOptionsCheckButton_OnClick()
    if (this:GetChecked()) then
        FlightMap.Opts[this.option] = true;
    else
        FlightMap.Opts[this.option] = false;
    end

    local base = "FlightMapOptionsFrame";
    for _, child in this.children do
        local other = getglobal(base .. "Opt" .. child);
        if other then
            if FlightMap.Opts[this.option] then
                OptionsFrame_EnableCheckBox(other, 1,
                    FlightMap.Opts[FLIGHTMAP_OPTIONS[child].option]);
            else
                OptionsFrame_DisableCheckBox(other);
            end
        end
    end
end

function FlightMap_UpdateTooltipFont()
    local size = 12;
	if FlightMap and FlightMap.Opts and FlightMap.Opts.fontSize then
	    size = FlightMap.Opts.fontSize;
	end
	
    local maxLines = 30;
    for i = 1, maxLines do
        local left = getglobal("FlightMapTooltipTextLeft" .. i)
        if left and left.SetFont then
		   left:SetFont("Fonts\\FRIZQT__.TTF", size) 
		end
        local right = getglobal("FlightMapTooltipTextRight" .. i)
		if right and right.SetFont then
		    right:SetFont("Fonts\\FRIZQT__.TTF", size)
		end
    end
end

if hooksecurefunc then
    hooksecurefunc("FlightMap_WorldMapButton_OnUpdate", function()
        if FlightMap and FlightMap.Opts then
            FlightMap_UpdateTooltipFont();
        end
    end);
else
    local _old_WorldMapButton_OnUpdate = FlightMap_WorldMapButton_OnUpdate;
    function FlightMap_WorldMapButton_OnUpdate(arg1)
        _old_WorldMapButton_OnUpdate(arg1);
        if FlightMap and FlightMap.Opts then
            FlightMap_UpdateTooltipFont();
        end
    end
end