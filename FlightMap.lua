-- FlightMap - AddOn to show inbound and outbound flightpaths from a given
--             zone on the World Map.  Additionally shows flight costs and
--             zone level ranges.
-- Copyright (c) 2005 Byron Ellacott (Dhask of Uther)
--
-- An unlimited license to use, reproduce and copy this work is granted, on
-- the condition that the licensee accepts all responsibility and liability
-- for any damage that may arise from the use of this AddOn.

-- Version number
FLIGHTMAP_VERSION   = "1.14";

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

local function lStripPoint(factionSV, point)
    if not factionSV then return; end
    for k, v in pairs(factionSV) do
        if v.Costs   then v.Costs[point]   = nil; end
        if v.Flights then v.Flights[point] = nil; end
    end
    factionSV[point] = nil;
end

-- Default option settings (also declared in Defaults.lua; this copy
-- is used as a fallback if Defaults.lua hasn't set them yet)
FLIGHTMAP_DEFAULT_OPTS = FLIGHTMAP_DEFAULT_OPTS or {
    showPaths = true,
    showPOIs = true,
    showAllInfo = false,
    showCosts = true,
    showTimes = true,
    showDestinations = true,
    showMultiHop = true,
    showZoneTooltip = true,
    showContinentPOIs = true,
    autoDismount = true,
    showPOITooltips = true,
    showLevelRanges = true,
    notifyTaskbar = true,
    notifySound = false,
    fontSize = 12,
    timerPos = { point = "TOP", x = 0, y = -11 },
    lockFlightTimes = false,
    showMinimapButton = true,
};

-- Strip saved overrides that are identical to (or within 1s of) the
-- built-in defaults, so only genuine differences occupy SavedVariables.
local function lStripDefaults(factionSV, defaults)
    if not factionSV then return; end
    for nodeKey, savedNode in pairs(factionSV) do
        local def = defaults[nodeKey];
        if def then
            -- Strip scalar fields matching the default
            for _, field in ipairs({"Name", "Zone", "Continent"}) do
                if savedNode[field] == def[field] then
                    savedNode[field] = nil;
                end
            end
            -- Strip Location if it matches within tolerance
            if savedNode.Location and def.Location then
                local allMatch = true;
                for _, space in ipairs({"Taxi", "Continent", "Zone"}) do
                    local sv = savedNode.Location[space];
                    local df = def.Location[space];
                    if sv and df then
                        if math.abs(sv.x - df.x) > 0.005
                        or math.abs(sv.y - df.y) > 0.005 then
                            allMatch = false; break;
                        end
                    end
                end
                if allMatch then savedNode.Location = nil; end
            end
            -- Strip flight times within 1 second of default
            if savedNode.Flights and def.Flights then
                for dest, svTime in pairs(savedNode.Flights) do
                    local dfTime = def.Flights[dest];
                    if dfTime and math.abs(svTime - dfTime) < 1.0 then
                        savedNode.Flights[dest] = nil;
                    end
                end
                if not next(savedNode.Flights) then
                    savedNode.Flights = nil;
                end
            end
            -- Strip costs matching default exactly
            if savedNode.Costs and def.Costs then
                for dest, svCost in pairs(savedNode.Costs) do
                    if def.Costs[dest] == svCost then
                        savedNode.Costs[dest] = nil;
                    end
                end
                if not next(savedNode.Costs) then
                    savedNode.Costs = nil;
                end
            end
            -- If nothing meaningful remains, drop the whole node
            local hasData = false;
            for _ in pairs(savedNode) do hasData = true; break; end
            if not hasData then factionSV[nodeKey] = nil; end
        end
    end
end

local function lSetDefaultData()
    -- Ensure per-character saved variable table exists
    if not FlightMapChar then FlightMapChar = {}; end

    -- Per-character flight knowledge
    if not FlightMapChar.Knowledge then
        FlightMapChar.Knowledge = {};
    end

    -- Per-character option settings
    if not FlightMapChar.Opts then
        FlightMapChar.Opts = {};
        for k, v in pairs(FLIGHTMAP_DEFAULT_OPTS) do
            FlightMapChar.Opts[k] = v;
        end
    else
        -- Fill in any newly added options
        for k, v in pairs(FLIGHTMAP_DEFAULT_OPTS) do
            if FlightMapChar.Opts[k] == nil then
                FlightMapChar.Opts[k] = v;
            end
        end
    end

    if FlightMap.Knowledge then
        for charKey, nodes in pairs(FlightMap.Knowledge) do
            if not FlightMapChar.Knowledge[charKey] then
                FlightMapChar.Knowledge[charKey] = nodes;
            end
        end
        FlightMap.Knowledge = nil;
    end
    if FlightMap.Opts then
        if not FlightMapChar.Opts then
            FlightMapChar.Opts = FlightMap.Opts;
        end
        FlightMap.Opts = nil;
    end

    -- Remove stale patch data
    lStripPoint(FlightMap[FLIGHTMAP_HORDE],    "1:461:226");  -- Valor's Rest (Horde)
    lStripPoint(FlightMap[FLIGHTMAP_ALLIANCE], "1:463:223");  -- Valor's Rest (Alliance)
    lStripPoint(FlightMap[FLIGHTMAP_ALLIANCE], "1:552:793");  -- Misplaced Moonglade

    -- Strip redundant saved data that matches built-in defaults
    lStripDefaults(FlightMap[FLIGHTMAP_HORDE],    FLIGHTMAP_HORDE_FLIGHTS);
    lStripDefaults(FlightMap[FLIGHTMAP_ALLIANCE], FLIGHTMAP_ALLIANCE_FLIGHTS);

    -- Rebuild the session map now that overrides are clean
    FlightMapUtil.resetFlightMapCache();

    -- Clean up very old format fields
    FlightMap.Locs  = nil;
    FlightMap.Times = nil;
end

-- Learn about the currently open taxi map.
-- Only writes to SavedVariables when a value differs from the built-in default.
local function lLearnTaxiNode()
    local map     = FlightMapUtil.getFlightMap();
    local faction = UnitFactionGroup("player");
    local sv      = FlightMapUtil.lGetOverrides(faction);
    local defaults = (faction == FLIGHTMAP_ALLIANCE)
                     and FLIGHTMAP_ALLIANCE_FLIGHTS
                     or  FLIGHTMAP_HORDE_FLIGHTS;

    local oldCont, oldZone = GetCurrentMapContinent(), GetCurrentMapZone();
    SetMapToCurrentZone();
    local thisCont = GetCurrentMapContinent();

    local thisNode;
    local destinations = {};
    local numNodes = NumTaxiNodes();
    for index = 1, numNodes, 1 do
        local tType = TaxiNodeGetType(index);
        if tType == "CURRENT" then
            thisNode = index;
        elseif tType == "REACHABLE" then
            local mx, my   = TaxiNodePosition(index);
            local destName = FlightMapUtil.makeNodeName(thisCont, mx, my);

            destinations[destName] = index;
            FlightMapUtil.knownNode(destName, true);

            -- New node not in default database — save it fully
            if not map[destName] then
                local stub = {
                    Name      = TaxiNodeName(index),
                    Zone      = "Unknown",
                    Continent = thisCont,
                    Flights   = {},
                    Costs     = {},
                    Location  = {
                        Taxi      = { x = mx, y = my },
                        Zone      = { x = 0,  y = 0  },
                        Continent = { x = 0,  y = 0  },
                    },
                };
                map[destName] = stub;
                sv[destName]  = stub;
            else
                -- Update in-session name; only persist if differs from default
                local taxiName = TaxiNodeName(index);
                map[destName].Name = taxiName;
                local df = defaults[destName];
                if not df or df.Name ~= taxiName then
                    if not sv[destName] then sv[destName] = {}; end
                    sv[destName].Name = taxiName;
                end
            end
        end
    end

    if thisNode then
        local mx, my   = TaxiNodePosition(thisNode);
        local thisName = FlightMapUtil.makeNodeName(thisCont, mx, my);
        local zoneName = FlightMapUtil.getZoneName();
        local zx, zy   = GetPlayerMapPosition("player");
        SetMapZoom(thisCont, nil);
        local cx, cy   = GetPlayerMapPosition("player");

        FlightMapUtil.knownNode(thisName, true);

        -- Ensure session map node exists with all sub-tables
        if not map[thisName] then map[thisName] = {}; end
        if not map[thisName].Flights then map[thisName].Flights = {}; end
        if not map[thisName].Costs   then map[thisName].Costs   = {}; end
        if not map[thisName].Routes  then map[thisName].Routes  = {}; end

        local df = defaults[thisName];

        -- Helper: write a scalar field to session + override only when changed
        local function saveField(field, val)
            map[thisName][field] = val;
            if not df or df[field] ~= val then
                if not sv[thisName] then sv[thisName] = {}; end
                sv[thisName][field] = val;
            end
        end

        saveField("Name",      TaxiNodeName(thisNode));
        saveField("Zone",      zoneName);
        saveField("Continent", thisCont);

        -- Location: save only when it meaningfully differs from default
        local newLoc = {
            Zone      = { x = zx, y = zy },
            Continent = { x = cx, y = cy },
            Taxi      = { x = mx, y = my },
        };
        map[thisName].Location = newLoc;
        local dfLoc = df and df.Location;
        local function coordClose(a, b) return math.abs(a - b) < 0.005; end
        local locMatchesDefault = dfLoc
            and dfLoc.Zone      and coordClose(dfLoc.Zone.x,      zx)
                                and coordClose(dfLoc.Zone.y,      zy)
            and dfLoc.Continent and coordClose(dfLoc.Continent.x, cx)
                                and coordClose(dfLoc.Continent.y, cy)
            and dfLoc.Taxi      and coordClose(dfLoc.Taxi.x,      mx)
                                and coordClose(dfLoc.Taxi.y,      my);
        if not locMatchesDefault then
            if not sv[thisName] then sv[thisName] = {}; end
            sv[thisName].Location = newLoc;
        end

        -- Destinations: costs and routes
        for k, v in pairs(destinations) do
            local newCost = TaxiNodeCost(v);
            map[thisName].Costs[k] = newCost;

            -- Persist cost only when it differs from default
            local dfCost = df and df.Costs and df.Costs[k];
            if dfCost ~= newCost then
                if not sv[thisName]       then sv[thisName]       = {}; end
                if not sv[thisName].Costs then sv[thisName].Costs = {}; end
                sv[thisName].Costs[k] = newCost;
            end

            local routes = GetNumRoutes(v);
            if routes > 1 then
                local totalTime = 0;
                local prevSpot  = thisName;
                local newRoute  = {};
                for r = 1, routes do
                    local dest = FlightMapUtil.makeNodeName(thisCont,
                            TaxiGetDestX(v, r), TaxiGetDestY(v, r));
                    table.insert(newRoute, dest);
                    if map[prevSpot] and map[prevSpot].Flights[dest]
                    and map[prevSpot].Flights[dest] > 0 and totalTime then
                        totalTime = totalTime + map[prevSpot].Flights[dest];
                    else
                        totalTime = nil;
                    end
                    prevSpot = dest;
                end

                local oldRoute = map[thisName].Routes[k];
                local isNewRoute = not oldRoute
                    or table.getn(oldRoute) ~= table.getn(newRoute);
                if not isNewRoute then
                    for idx = 1, table.getn(newRoute) do
                        if newRoute[idx] ~= oldRoute[idx] then
                            isNewRoute = true; break;
                        end
                    end
                end

                if isNewRoute or map[thisName].Flights[k] == 0 then
                    map[thisName].Flights[k] = totalTime;
                    map[thisName].Routes[k]  = newRoute;

                    -- Persist route only when it differs from default
                    local dfRoute = df and df.Routes and df.Routes[k];
                    local routeDiffers = not dfRoute
                        or table.getn(dfRoute) ~= table.getn(newRoute);
                    if not routeDiffers then
                        for i = 1, table.getn(newRoute) do
                            if newRoute[i] ~= dfRoute[i] then
                                routeDiffers = true; break;
                            end
                        end
                    end
                    if routeDiffers then
                        if not sv[thisName]        then sv[thisName]        = {}; end
                        if not sv[thisName].Routes then sv[thisName].Routes = {}; end
                        sv[thisName].Routes[k] = newRoute;
                    end
                end
            else
                map[thisName].Routes[k] = nil;
                if sv[thisName] and sv[thisName].Routes then
                    sv[thisName].Routes[k] = nil;
                end
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
    if not FlightMapChar.Opts.autoDismount then return; end

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
    if cost ~= nil and FlightMapChar.Opts.showCosts then
        local dosh = FlightMapUtil.formatMoney(cost);
        if cost == 0 then dosh = FLIGHTMAP_NO_COST; end
        result = dosh;
    end
    if secs ~= nil and FlightMapChar.Opts.showTimes then
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

    if not source and FlightMapChar.Opts.showDestinations then
        for dest, secs in data.Flights do
            local islocal = (not data.Routes or not data.Routes[dest]);
            local destData = map[dest];
            if destData and (islocal or FlightMapChar.Opts.showMultiHop) then
                local name, _ = FlightMapUtil.getNameAndZone(destData.Name);
                local cost = data.Costs[dest];
                local extra = lFormatExtra(cost, secs);
                if FlightMapUtil.knownNode(dest) then
                    tooltip:AddDoubleLine(prefix .. name, extra,
                        1, 1, 1, 1, 1, 1);
                elseif FlightMapChar.Opts.showAllInfo then
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

    if not FlightMapChar.Opts.showZoneTooltip then
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
    if levels and FlightMapChar.Opts.showLevelRanges then
        FlightMapTooltip:AddLine(levels, title.r, title.g, title.b);
    end

    local nodes = FlightMapUtil.getNodesInZone(zoneName, true);

    local flights = 0;
    for node, data in nodes do
        if FlightMapUtil.knownNode(node) or FlightMapChar.Opts.showAllInfo then
            flights = flights + lAddFlightsForNode(FlightMapTooltip, node, "");
        end
    end

    FlightMapTooltip:SetBackdropColor(0, 0, 0, 0.5);
    FlightMapTooltip:SetBackdropBorderColor(0, 0, 0, 0);
    FlightMapTooltip:ClearAllPoints();
    FlightMapTooltip:SetPoint("BOTTOMLEFT", "WorldMapDetailFrame",
            "BOTTOMLEFT", 0, 0);

    if flights > 0 or (levels and FlightMapChar.Opts.showLevelRanges) then
        if FlightMap_IsCartographerActive() then
            FlightMap_FixZoneTooltipBackdrop(FlightMapTooltip);
        end
        FlightMapTooltip:Show();
    else
        FlightMapTooltip:Hide();
    end

    FlightMapTooltip:ClearAllPoints();
    FlightMapTooltip:SetPoint("BOTTOMLEFT", WorldMapDetailFrame);

    FlightMap_FixMagnifyCartographerAnchor(FlightMapTooltip);
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
        if not FlightMapChar.Opts.showAllInfo then
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

    if mapZone ~= 0 and FlightMapChar.Opts.showPOIs then
        local nodes = FlightMapUtil.getNodesInZone(zoneName, false);
        for node, data in nodes do
            if lShowNodePOI(node, data, "Zone", POI) then
                POI = POI + 1;
            end
        end
    elseif continent ~= 0 and FlightMapChar.Opts.showPOIs and FlightMapChar.Opts.showContinentPOIs then
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

    if zoneName and FlightMapChar.Opts.showPaths then
        local nodes = FlightMapUtil.getNodesInZone(zoneName, true);
        for node, data in nodes do
            if FlightMapChar.Opts.showAllInfo or FlightMapUtil.knownNode(node) then
                for dest, duration in data.Flights do
                    if not (data.Routes and data.Routes[dest])
                    and (FlightMapChar.Opts.showAllInfo
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
    if not FlightMapChar.Opts.showPOITooltips then return; end
    local x, y = this:GetCenter();
    local parentX, parentY = WorldMapDetailFrame:GetCenter();
    if (x > parentX) then
        WorldMapTooltip:SetOwner(this, "ANCHOR_LEFT");
    else
        WorldMapTooltip:SetOwner(this, "ANCHOR_RIGHT");
    end
    lAddFlightsForNode(WorldMapTooltip, this.node, "");
    if FlightMap_IsCartographerActive() then
        WorldMapTooltip:SetAlpha(1);
    end
    WorldMapTooltip:Show();

    WorldMapTooltip:SetFrameStrata("TOOLTIP");
    WorldMapTooltip:SetFrameLevel((FlightMapTooltip:GetFrameLevel() or 0) + 10);
end

---------------- Initialization functions -----------------

-- /flightmap handler
function FlightMap_OnSlashCmd(args)
    if args == FLIGHTMAP_RESET then
        local def = FLIGHTMAP_DEFAULT_OPTS.timerPos;
        FlightMapTimesFrame:ClearAllPoints();
        FlightMapTimesFrame:SetPoint(def.point, UIParent, def.point, def.x, def.y);
        FlightMapTimesFrame:SetUserPlaced(false);
        FlightMapChar.Opts.timerPos = { point = def.point, x = def.x, y = def.y };
    elseif args == FLIGHTMAP_SHOWMAP then
        FlightMapTaxi_ShowContinent();
    elseif args == FLIGHTMAP_LOCKTIMES then
        FlightMapChar.Opts.lockFlightTimes = not FlightMapChar.Opts.lockFlightTimes;
        DEFAULT_CHAT_FRAME:AddMessage(
            FLIGHTMAP_TIMESLOCKED[FlightMapChar.Opts.lockFlightTimes],
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

        -- Apply saved timer bar position
        local pos = FlightMapChar.Opts.timerPos;
        if pos and pos.point then
            FlightMapTimesFrame:ClearAllPoints();
            FlightMapTimesFrame:SetPoint(pos.point, UIParent, pos.point, pos.x, pos.y);
        end

		FlightMap_UpdateTooltipFont();
        FlightMap_UpdateMinimapButton();

        if (myAddOnsFrame_Register) then
            myAddOnsFrame_Register({
                name         = "FlightMap",
                version      = FLIGHTMAP_VERSION,
                releaseDate  = FLIGHTMAP_RELEASE,
                author       = "Original addon: Dhask; Enhanced version: Drakensangs",
                category     = MYADDONS_CATEGORY_MAP,
                optionsframe = "FlightMapOptionsFrame",
            });
        end
    end
end

----------------- Options panel functions -----------------

function FlightMapOptionsFrame_OnShow()
    if not FlightMapChar then FlightMapChar = {}; end
    if not FlightMapChar.Opts then
        FlightMapChar.Opts = {};
        for k, v in pairs(FLIGHTMAP_DEFAULT_OPTS) do
            FlightMapChar.Opts[k] = v;
        end
    end

    FlightMapOptionsFrameClose:SetText(FLIGHTMAP_OPTIONS_CLOSE);
    FlightMapOptionsFrameTitle:SetText(FLIGHTMAP_OPTIONS_TITLE);

    local base = "FlightMapOptionsFrame"
    for optid, option in pairs(FLIGHTMAP_OPTIONS or {}) do
        local name = base .. "Opt" .. optid;
        local button = getglobal(name);
        local label = getglobal(name .. "Text");
        if button and label then
            OptionsFrame_EnableCheckBox(button, 1, FlightMapChar.Opts[option.option]);
            label:SetText(option.label);
            button.tooltipText = option.tooltip;
            button.option = option.option;
            button.children = option.children or {};
        end
    end

    for optid, option in pairs(FLIGHTMAP_OPTIONS or {}) do
        for _, child in pairs(option.children or {}) do
            local other = getglobal(base .. "Opt" .. child);
            if other then
                if FlightMapChar.Opts[option.option] then
                    OptionsFrame_EnableCheckBox(other, 1,
                        FlightMapChar.Opts[FLIGHTMAP_OPTIONS[child].option]);
                else
                    OptionsFrame_DisableCheckBox(other);
                end
            end
        end
    end

    local unitXPLoaded = IsAddOnLoaded and IsAddOnLoaded("UnitXP_SP3_Addon") and UnitXP;
    local opt16 = getglobal(base .. "Opt16");
    local opt17 = getglobal(base .. "Opt17");
    if opt16 then
        if unitXPLoaded then
            OptionsFrame_EnableCheckBox(opt16, 1, FlightMapChar.Opts.notifyTaskbar);
        else
            OptionsFrame_DisableCheckBox(opt16);
        end
    end
    if opt17 then
        if unitXPLoaded then
            OptionsFrame_EnableCheckBox(opt17, 1, FlightMapChar.Opts.notifySound);
        else
            OptionsFrame_DisableCheckBox(opt17);
        end
    end

    if not FlightMapUnitXPSeparator then
        FlightMapUnitXPSeparator = FlightMapOptionsFrame:CreateFontString(
            "FlightMapUnitXPSeparator", "ARTWORK", "GameFontNormalSmall");
        FlightMapUnitXPSeparator:SetPoint("TOPLEFT", FlightMapOptionsFrame, "TOPLEFT", 220, -210);
        FlightMapUnitXPSeparator:SetText("UnitXP SP3:");
    end
    FlightMapUnitXPSeparator:Show();

    if not FlightMapFontSizeSlider then
        CreateFrame("Slider", "FlightMapFontSizeSlider", FlightMapOptionsFrame, "OptionsSliderTemplate");
        FlightMapFontSizeSlider:SetWidth(280);
        FlightMapFontSizeSlider:SetHeight(16);
        FlightMapFontSizeSlider:SetOrientation("HORIZONTAL");
        FlightMapFontSizeSlider:SetPoint("TOP", FlightMapOptionsFrameClose, "BOTTOM", 0, 55);

        FlightMapFontSizeSlider:SetMinMaxValues(8, 20);
        FlightMapFontSizeSlider:SetValueStep(1);

        local txt = getglobal("FlightMapFontSizeSliderText");
        if txt then txt:SetText((FLIGHTMAP_TOOLTIP_FONT_SIZE or "Tooltip font size") .. ": " .. (FlightMapChar.Opts.fontSize or 12)); end
        local low = getglobal("FlightMapFontSizeSliderLow");
        local high = getglobal("FlightMapFontSizeSliderHigh");
		if low then low:SetText("8"); end
		if high then high:SetText("20"); end

        FlightMapFontSizeSlider.tooltipText = FLIGHTMAP_TOOLTIP_FONT_SIZE_TIP or "Adjusts the font size of the FlightMap tooltip text.";
        
        FlightMapFontSizeSlider:SetScript("OnEnter", function()
            if FlightMapFontSizeSlider.tooltipText then
                GameTooltip_AddNewbieTip(FlightMapFontSizeSlider.tooltipText, 1, 1, 1);
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
			
			if not FlightMapChar then FlightMapChar = {}; end
			if not FlightMapChar.Opts then FlightMapChar.Opts = {}; end
			FlightMapChar.Opts.fontSize = val;

			local txt = getglobal("FlightMapFontSizeSliderText");
			if txt then txt:SetText((FLIGHTMAP_TOOLTIP_FONT_SIZE or "Tooltip font size") .. ": " .. val); end

			if FlightMap_UpdateTooltipFont then
			    FlightMap_UpdateTooltipFont();
			end
		end
		
        FlightMapFontSizeSlider:SetScript("OnValueChanged", FlightMapFontSizeSlider_Internal_OnValueChanged);
		
    end

    local currentFontSize = (FlightMapChar.Opts and FlightMapChar.Opts.fontSize) or 12;
    FlightMapFontSizeSlider:SetValue(currentFontSize);
    local fsTxt = getglobal("FlightMapFontSizeSliderText");
    if fsTxt then fsTxt:SetText((FLIGHTMAP_TOOLTIP_FONT_SIZE or "Tooltip font size") .. ": " .. currentFontSize); end
	if FlightMap_UpdateTooltipFont then FlightMap_UpdateTooltipFont(); end
end

function FlightMapOptionsFrame_OnHide()
    if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
        ShowUIPanel(myAddOnsFrame);
    end
end

function FlightMapOptionsCheckButton_OnClick()
    if not FlightMapChar or not FlightMapChar.Opts then return; end

    -- Prevent toggling UnitXP notify options when UnitXP SP3 is not loaded
    if (this.option == "notifyTaskbar" or this.option == "notifySound") then
        if not (IsAddOnLoaded and IsAddOnLoaded("UnitXP_SP3_Addon") and UnitXP) then
            return;
        end
    end
    if (this:GetChecked()) then
        FlightMapChar.Opts[this.option] = true;
    else
        FlightMapChar.Opts[this.option] = false;
    end

    if this.option == "showMinimapButton" then
        FlightMap_UpdateMinimapButton();
    end

    local base = "FlightMapOptionsFrame";
    for _, child in pairs(this.children or {}) do
        local other = getglobal(base .. "Opt" .. child);
        if other then
            if FlightMapChar.Opts[this.option] then
                OptionsFrame_EnableCheckBox(other, 1,
                    FlightMapChar.Opts[FLIGHTMAP_OPTIONS[child].option]);
            else
                OptionsFrame_DisableCheckBox(other);
            end
        end
    end
end

function FlightMap_UpdateTooltipFont()
    local size = 12;
	if FlightMap and FlightMapChar.Opts and FlightMapChar.Opts.fontSize then
	    size = FlightMapChar.Opts.fontSize;
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
        if FlightMap and FlightMapChar.Opts then
            FlightMap_UpdateTooltipFont();
        end
    end);
else
    local _old_WorldMapButton_OnUpdate = FlightMap_WorldMapButton_OnUpdate;
    function FlightMap_WorldMapButton_OnUpdate(arg1)
        _old_WorldMapButton_OnUpdate(arg1);
        if FlightMap and FlightMapChar.Opts then
            FlightMap_UpdateTooltipFont();
        end
    end
end
----------------- Minimap Button -----------------

local FLIGHTMAP_MINIMAP_DEFAULT_ANGLE = 225;

local function lMinimapButtonGetAngle()
    if FlightMapChar and FlightMapChar.minimapButtonAngle then
        return FlightMapChar.minimapButtonAngle;
    end
    return FLIGHTMAP_MINIMAP_DEFAULT_ANGLE;
end

local function lMinimapButtonSaveAngle(angle)
    if not FlightMapChar then FlightMapChar = {}; end
    FlightMapChar.minimapButtonAngle = angle;
end

local function lUpdateMinimapButtonPosition()
    local frame = FlightMapMinimapButtonFrame;
    if not frame then return; end
    local angle = lMinimapButtonGetAngle();
    local rad = math.rad(angle);
    local radius = 80;
    local x = math.cos(rad) * radius;
    local y = math.sin(rad) * radius;
    frame:ClearAllPoints();
    frame:SetPoint("CENTER", Minimap, "CENTER", x, y);
end

function FlightMap_UpdateMinimapButton()
    local frame = FlightMapMinimapButtonFrame;
    if not frame then return; end
    if FlightMapChar and FlightMapChar.Opts and FlightMapChar.Opts.showMinimapButton then
        frame:Show();
        lUpdateMinimapButtonPosition();
    else
        frame:Hide();
    end
end

function FlightMapMinimapButton_OnUpdate()
    local mx, my = Minimap:GetCenter();
    local scale  = Minimap:GetEffectiveScale();
    local cx, cy = GetCursorPosition();
    cx = cx / scale;
    cy = cy / scale;
    local angle  = math.deg(math.atan2(cy - my, cx - mx));
    local frame = FlightMapMinimapButtonFrame;
    frame:ClearAllPoints();
    frame:SetPoint("CENTER", Minimap, "CENTER",
        math.cos(math.rad(angle)) * 80, math.sin(math.rad(angle)) * 80);
    lMinimapButtonSaveAngle(angle);
end

function FlightMapMinimapButton_OnMouseDown(button)
    if button == "RightButton" then
        FlightMapMinimapButton:SetScript("OnUpdate", FlightMapMinimapButton_OnUpdate);
    end
end

function FlightMapMinimapButton_OnMouseUp(button)
    if button == "RightButton" then
        FlightMapMinimapButton:SetScript("OnUpdate", nil);
        lUpdateMinimapButtonPosition();
    elseif button == "LeftButton" then
        if IsControlKeyDown() then
            FlightMapTaxi_ShowContinent();
        else
            if FlightMapOptionsFrame:IsVisible() then
                HideUIPanel(FlightMapOptionsFrame);
            else
                ShowUIPanel(FlightMapOptionsFrame);
            end
        end
    end
end

function FlightMapMinimapButton_OnEnter()
    GameTooltip:SetOwner(FlightMapMinimapButton, "ANCHOR_LEFT");
    GameTooltip:SetText("FlightMap");
    GameTooltip:AddLine(FLIGHTMAP_MINIMAP_TIP1, 1, 1, 1);
    GameTooltip:AddLine(FLIGHTMAP_MINIMAP_TIP3, 1, 1, 1);
    GameTooltip:AddLine(FLIGHTMAP_MINIMAP_TIP2, 1, 1, 1);
    GameTooltip:Show();
end

function FlightMapMinimapButton_OnLeave()
    GameTooltip:Hide();
end

----------------- pfUI -----------------

local function FlightMap_ApplypfUISkin()
    if not IsAddOnLoaded("pfUI") then return end
    if not pfUI or not pfUI.api then return end

    local CreateBackdrop      = pfUI.api.CreateBackdrop;
    local CreateBackdropShadow = pfUI.api.CreateBackdropShadow;
    local StripTextures       = pfUI.api.StripTextures;
    local SkinButton          = pfUI.api.SkinButton;
    local SkinCheckbox        = pfUI.api.SkinCheckbox;
    local SkinSlider          = pfUI.api.SkinSlider;

    local frame = FlightMapOptionsFrame;
    if not frame then return end

    -- Strip default Blizzard textures and apply pfUI backdrop
    StripTextures(frame, true);
    CreateBackdrop(frame, nil, true, 0.85);
    CreateBackdropShadow(frame);

    local title = FlightMapOptionsFrameTitle;
    if title then
        title:SetFont(pfUI.font_default, pfUI_config.global.font_size + 2);
        title:ClearAllPoints();
        title:SetPoint("TOP", frame, "TOP", 0, -10);
    end

    SkinButton(FlightMapOptionsFrameClose);

    local checkboxes = {
        "FlightMapOptionsFrameOpt1",  "FlightMapOptionsFrameOpt2",
        "FlightMapOptionsFrameOpt3",  "FlightMapOptionsFrameOpt4",
        "FlightMapOptionsFrameOpt5",  "FlightMapOptionsFrameOpt6",
        "FlightMapOptionsFrameOpt7",  "FlightMapOptionsFrameOpt8",
        "FlightMapOptionsFrameOpt9",  "FlightMapOptionsFrameOpt10",
        "FlightMapOptionsFrameOpt11", "FlightMapOptionsFrameOpt12",
        "FlightMapOptionsFrameOpt13", "FlightMapOptionsFrameOpt14",
        "FlightMapOptionsFrameOpt15", "FlightMapOptionsFrameOpt16",
        "FlightMapOptionsFrameOpt17", "FlightMapOptionsFrameOpt18",
    };
    for _, name in ipairs(checkboxes) do
        local cb = getglobal(name);
        if cb then SkinCheckbox(cb, 26) end
    end

    local function lSkinSlider()
        local slider = FlightMapFontSizeSlider;
        if not slider or slider._pfSkinned then return end
        slider._pfSkinned = true;
        SkinSlider(slider);
    end

    if FlightMapFontSizeSlider then
        lSkinSlider();
    else
        local origOnShow = FlightMapOptionsFrame:GetScript("OnShow");
        FlightMapOptionsFrame:SetScript("OnShow", function()
            if origOnShow then origOnShow() end
            lSkinSlider();
        end);
    end

    local SkinDropDown = pfUI.api.SkinDropDown;
    if SkinDropDown and FlightMapTaxiContinents then
        SkinDropDown(FlightMapTaxiContinents);
    end
end

do
    local lSkinWatcher = CreateFrame("Frame");
    lSkinWatcher:RegisterEvent("ADDON_LOADED");
    lSkinWatcher:RegisterEvent("PLAYER_ENTERING_WORLD");
    lSkinWatcher:SetScript("OnEvent", function()
        if IsAddOnLoaded("pfUI") and pfUI and pfUI.api then
            FlightMap_ApplypfUISkin();
            lSkinWatcher:UnregisterAllEvents();
        end
    end);
end

--Cartographer compatibility
local FLIGHTMAP_TOOLTIP_BACKDROP = {
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 },
};

local lCartographerDetected = false;

function FlightMap_IsCartographerActive()
    return lCartographerDetected;
end

function FlightMap_RaiseAboveCartographer(tooltip)
    tooltip:SetAlpha(1);
    tooltip:SetFrameStrata("TOOLTIP");
    tooltip:SetFrameLevel((WorldMapFrame:GetFrameLevel() or 0) + 50);
end

function FlightMap_FixZoneTooltipBackdrop(tooltip)
    tooltip:SetBackdrop(FLIGHTMAP_TOOLTIP_BACKDROP);
    tooltip:SetBackdropColor(0, 0, 0, 0.5);
    tooltip:SetBackdropBorderColor(0, 0, 0, 0);
    FlightMap_RaiseAboveCartographer(tooltip);
end

do
    local lCartoWatcher = CreateFrame("Frame");
    lCartoWatcher:RegisterEvent("ADDON_LOADED");
    lCartoWatcher:RegisterEvent("PLAYER_ENTERING_WORLD");
    lCartoWatcher:SetScript("OnEvent", function()
        if IsAddOnLoaded("Cartographer") and Cartographer then
            lCartographerDetected = true;
            lCartoWatcher:UnregisterAllEvents();
        end
    end);
end

-- Magnify compatibility
local lMagnifyDetected = false;

function FlightMap_IsMagnifyActive()
    return lMagnifyDetected;
end

function FlightMap_FixShaguMapSize()
    if FlightMap_IsCartographerActive() then
        return;
    end
    if not IsAddOnLoaded("ShaguTweaks") then
        return;
    end

    local worldMapWindowEnabled = ShaguTweaks_config
            and ShaguTweaks_config["WorldMap Window"] == 1;
    if worldMapWindowEnabled then
        return;
    end

    if WorldMapFrameScrollFrame then
        MAGNIFY_MIN_ZOOM = 1;
        WorldMapFrameScrollFrame:SetWidth(1002);
        WorldMapFrameScrollFrame:SetHeight(668);
        WorldMapFrameScrollFrame:ClearAllPoints();
        WorldMapFrameScrollFrame:SetPoint("TOP", WorldMapFrame, 0, -70);
        if WorldMapDetailFrame then
            WorldMapFrameScrollFrame:SetScrollChild(WorldMapDetailFrame);
        end
    end

    if WorldMapFrameAreaFrame then
        WorldMapFrameAreaFrame:SetParent(WorldMapFrame);
        WorldMapFrameAreaFrame:ClearAllPoints();
        WorldMapFrameAreaFrame:SetPoint("TOP", WorldMapFrame, 0, -60);
        WorldMapFrameAreaFrame:SetFrameStrata("FULLSCREEN_DIALOG");
    end

    if Magnify_ResetZoom then
        Magnify_ResetZoom();
    end
end

function FlightMap_FixMagnifyCartographerAnchor(tooltip)
    if not FlightMap_IsMagnifyActive() then
        return;
    end

    local cartographerActive = FlightMap_IsCartographerActive();

    local lookNFeelActive = cartographerActive and Cartographer_LookNFeel
            and Cartographer:IsModuleActive(Cartographer_LookNFeel);

    local shaguTweaksActive = IsAddOnLoaded("ShaguTweaks");

    local worldMapWindowEnabled = shaguTweaksActive and ShaguTweaks_config
            and ShaguTweaks_config["WorldMap Window"] == 1;

    local OFFSET_X, OFFSET_Y;
    if cartographerActive and lookNFeelActive then
        OFFSET_X = 10;
        OFFSET_Y = 31;
    elseif cartographerActive then
        OFFSET_X = 181;
        OFFSET_Y = 31;
    elseif shaguTweaksActive and not worldMapWindowEnabled then
        OFFSET_X = 181;
        OFFSET_Y = 31;
    elseif not shaguTweaksActive then
        OFFSET_X = 181;
        OFFSET_Y = 31;
    end

    if not OFFSET_X then
        return;
    end

    local meta = getmetatable(tooltip);
    local idx = meta and meta.__index;
    local nativeSetPoint;
    if type(idx) == "table" then
        nativeSetPoint = idx.SetPoint;
    elseif type(idx) == "function" then
        nativeSetPoint = idx(tooltip, "SetPoint");
    end

    if nativeSetPoint then
        nativeSetPoint(tooltip, "BOTTOMLEFT", WorldMapFrame, "BOTTOMLEFT",
                OFFSET_X, OFFSET_Y);
    else
        local saved = tooltip.SetPoint;
        tooltip.SetPoint = nil;
        tooltip:SetPoint("BOTTOMLEFT", WorldMapFrame, "BOTTOMLEFT",
                OFFSET_X, OFFSET_Y);
        tooltip.SetPoint = saved;
    end

    tooltip:SetFrameStrata("TOOLTIP");
end

do
    local lMagnifyWatcher = CreateFrame("Frame");
    lMagnifyWatcher:RegisterEvent("ADDON_LOADED");
    lMagnifyWatcher:RegisterEvent("PLAYER_ENTERING_WORLD");
    lMagnifyWatcher:SetScript("OnEvent", function()
        if IsAddOnLoaded("Magnify") then
            lMagnifyDetected = true;
            lMagnifyWatcher:UnregisterAllEvents();
        end
    end);
end

-- TurtleWoW compatibility
if not OptionsFrame_EnableCheckBox then
    function OptionsFrame_EnableCheckBox(checkbox, enable, checked)
        if not checkbox then
            return;
        end

        if enable then
            checkbox:Enable();
        else
            checkbox:Disable();
        end
        checkbox:SetChecked(checked);

        local name = checkbox.GetName and checkbox:GetName();
        local text = name and getglobal(name .. "Text");
        if text then
            local color = enable and NORMAL_FONT_COLOR or GRAY_FONT_COLOR;
            if color then
                text:SetTextColor(color.r, color.g, color.b);
            elseif enable then
                text:SetTextColor(1, 1, 1);
            else
                text:SetTextColor(0.5, 0.5, 0.5);
            end
        end
    end
end

if not OptionsFrame_DisableCheckBox then
    function OptionsFrame_DisableCheckBox(checkbox)
        OptionsFrame_EnableCheckBox(checkbox, nil,
                checkbox and checkbox:GetChecked());
    end
end

do
    local lShaguMapSizeWatcher = CreateFrame("Frame");
    lShaguMapSizeWatcher:RegisterEvent("PLAYER_ENTERING_WORLD");
    lShaguMapSizeWatcher:SetScript("OnEvent", function()
        lShaguMapSizeWatcher:UnregisterAllEvents();

        local origOnShow = WorldMapFrame:GetScript("OnShow");
        WorldMapFrame:SetScript("OnShow", function()
            if origOnShow then
                origOnShow();
            end
            if FlightMap_IsMagnifyActive() then
                FlightMap_FixShaguMapSize();
            end
        end);
    end);
end
