local addonName, addonTable = ...

-- Créer le module UI si il n'existe pas
addonTable.UI = addonTable.UI or {}

-- Références aux modules
local Core = addonTable.Core

-- Module ModelViewer
local ModelViewer = {}
addonTable.UI.ModelViewer = ModelViewer

-------------------------------------------------
-- Variables locales
-------------------------------------------------
local modelSection
local model
local modelMountName
local currentMountData
local currentMountName

-------------------------------------------------
-- Interface publique
-------------------------------------------------
function ModelViewer:CreateModelSection(parentFrame)
    if modelSection then
        return modelSection
    end
    
    -- Section pour le modèle 3D (côté gauche)
    modelSection = CreateFrame("Frame", nil, parentFrame, "BackdropTemplate")
    modelSection:SetSize(380, 620)
    modelSection:SetPoint("TOPLEFT", 20, -70)
    modelSection:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    modelSection:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
    modelSection:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

    -- Titre de la section modèle
    local modelTitle = modelSection:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    modelTitle:SetPoint("TOP", 0, -15)
    modelTitle:SetText("Aperçu Monture")
    modelTitle:SetTextColor(1, 0.8, 0)

    -- Nom de la monture affichée
    modelMountName = modelSection:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    modelMountName:SetPoint("TOP", modelTitle, "BOTTOM", 0, -10)
    modelMountName:SetText("Survolez une monture pour l'afficher")
    modelMountName:SetTextColor(0.7, 0.7, 0.7)

    -- Modèle 3D
    model = CreateFrame("PlayerModel", nil, modelSection)
    model:SetSize(340, 400)
    model:SetPoint("TOP", modelMountName, "BOTTOM", 0, -20)
    model:EnableMouseWheel(true)
    model:SetScript("OnMouseWheel", function(self, delta)
        local currentRotation = self.currentRotation or 0
        currentRotation = currentRotation + (delta * 0.2)
        if currentRotation > 6.28 then currentRotation = 0 end
        if currentRotation < 0 then currentRotation = 6.28 end
        self:SetRotation(currentRotation)
        self.currentRotation = currentRotation
    end)

    -- Instructions de contrôle
    local instructions = modelSection:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    instructions:SetPoint("TOP", model, "BOTTOM", 0, -10)
    instructions:SetText("Molette de la souris pour faire tourner")
    instructions:SetTextColor(0.7, 0.7, 0.7)

    -- Informations détaillées de la monture
    local detailsFrame = self:CreateDetailsFrame(modelSection)
    detailsFrame:SetPoint("TOP", instructions, "BOTTOM", 0, -10)

    -- Boutons d'action
    self:CreateActionButtons(modelSection, detailsFrame)

    -- Cacher la section par défaut
    modelSection:Hide()

    return modelSection
end

function ModelViewer:CreateDetailsFrame(parent)
    local detailsFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    detailsFrame:SetSize(340, 120)
    detailsFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 4,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    detailsFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
    detailsFrame:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

    -- Informations de la monture
    local infoText = detailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    infoText:SetPoint("TOPLEFT", 10, -10)
    infoText:SetPoint("TOPRIGHT", -10, -10)
    infoText:SetJustifyH("LEFT")
    infoText:SetText("Aucune monture sélectionnée")
    infoText:SetTextColor(0.8, 0.8, 0.8)
    detailsFrame.infoText = infoText

    return detailsFrame
end

function ModelViewer:CreateActionButtons(parent, detailsFrame)
    local buttonContainer = CreateFrame("Frame", nil, parent)
    buttonContainer:SetSize(340, 40)
    buttonContainer:SetPoint("TOP", detailsFrame, "BOTTOM", 0, -10)

    -- Bouton d'information détaillée
    local infoButton = CreateFrame("Button", nil, buttonContainer, "GameMenuButtonTemplate")
    infoButton:SetSize(100, 30)
    infoButton:SetPoint("LEFT", 10, 0)
    infoButton:SetText("Détails")
    infoButton:SetScript("OnClick", function(self)
        ModelViewer:ShowMountDetails()
    end)

    -- Bouton pour ouvrir le journal des montures
    local journalButton = CreateFrame("Button", nil, buttonContainer, "GameMenuButtonTemplate")
    journalButton:SetSize(100, 30)
    journalButton:SetPoint("CENTER", 0, 0)
    journalButton:SetText("Journal")
    journalButton:SetScript("OnClick", function(self)
        ModelViewer:OpenMountJournal()
    end)

    -- Bouton pour copier le lien
    local linkButton = CreateFrame("Button", nil, buttonContainer, "GameMenuButtonTemplate")
    linkButton:SetSize(100, 30)
    linkButton:SetPoint("RIGHT", -10, 0)
    linkButton:SetText("Lien")
    linkButton:SetScript("OnClick", function(self)
        ModelViewer:CopyMountLink()
    end)

    -- Stocker les références
    buttonContainer.infoButton = infoButton
    buttonContainer.journalButton = journalButton
    buttonContainer.linkButton = linkButton
    
    parent.actionButtons = buttonContainer
end

function ModelViewer:UpdateModel(mountName, mountData)
    if not modelSection or not model or not mountData then
        return
    end

    -- Stocker les données actuelles
    currentMountData = mountData
    currentMountName = mountName

    -- Mettre à jour le nom
    if modelMountName then
        local isCollected = Core and Core.HasMount(mountData.spellId)
        local nameColor = isCollected and "|cff00FF00" or "|cffFFFFFF"
        modelMountName:SetText(nameColor .. mountName)
    end

    -- Afficher le modèle 3D si possible
    if mountData.creatureDisplayId then
        model:SetDisplayInfo(mountData.creatureDisplayId)
        model:SetCamera(1)
        model:SetRotation(0.78)
        model.currentRotation = 0.78
        modelSection:Show()
    else
        -- Pas de modèle 3D disponible, afficher quand même la section avec les infos
        model:ClearModel()
        modelSection:Show()
    end

    -- Mettre à jour les détails
    self:UpdateDetails(mountData)
end

function ModelViewer:UpdateDetails(mountData)
    if not modelSection or not currentMountData then
        return
    end

    local detailsFrame = modelSection:GetChildren()
    for _, child in ipairs({modelSection:GetChildren()}) do
        if child.infoText then
            local infoLines = {}
            
            -- Catégorie et type de source
            if mountData.category then
                table.insert(infoLines, "|cffFFD700Catégorie:|r " .. mountData.category)
            end
            
            if mountData.sourceTypeLocalized then
                table.insert(infoLines, "|cffFFD700Type:|r " .. mountData.sourceTypeLocalized)
            end
            
            -- Source et boss
            if mountData.source then
                table.insert(infoLines, "|cffFFD700Source:|r " .. mountData.source)
            end
            
            if mountData.boss then
                table.insert(infoLines, "|cffFFD700Boss:|r " .. mountData.boss)
            end
            
            -- Taux de drop et difficulté
            if mountData.dropChance then
                table.insert(infoLines, "|cffFFD700Taux:|r " .. mountData.dropChance)
            end
            
            if mountData.difficulty then
                table.insert(infoLines, "|cffFFD700Difficulté:|r " .. mountData.difficulty)
            end
            
            -- Faction si applicable
            if mountData.factionText and mountData.factionText ~= "" then
                local factionColor = mountData.faction == "Alliance" and "|cff0080ff" or "|cffff0000"
                table.insert(infoLines, "|cffFFD700Faction:|r " .. factionColor .. mountData.factionText)
            end
            
            -- Status de collection
            local isCollected = Core and Core.HasMount(mountData.spellId)
            local statusColor = isCollected and "|cff00FF00" or "|cffFF0000"
            local statusText = isCollected and "COLLECTÉ" or "MANQUANT"
            table.insert(infoLines, "|cffFFD700Statut:|r " .. statusColor .. statusText)
            
            child.infoText:SetText(table.concat(infoLines, "\n"))
            break
        end
    end
end

function ModelViewer:ShowMountDetails()
    if not currentMountData or not currentMountName then
        print("|cffff8800[SmartMounts]|r Aucune monture sélectionnée")
        return
    end

    print("|cff00ff00=== Détails de la monture ===|r")
    print("|cffFFD700Nom:|r " .. (currentMountName or "N/A"))
    print("|cffFFD700ID Sort:|r " .. (currentMountData.spellId or "N/A"))
    print("|cffFFD700Catégorie:|r " .. (currentMountData.category or "N/A"))
    print("|cffFFD700Expansion:|r " .. (currentMountData.expansion or "N/A"))
    print("|cffFFD700Source:|r " .. (currentMountData.source or "N/A"))
    
    if currentMountData.boss then
        print("|cffFFD700Boss:|r " .. currentMountData.boss)
    end
    
    if currentMountData.dropChance then
        print("|cffFFD700Taux de drop:|r " .. currentMountData.dropChance)
    end
    
    if currentMountData.difficulty then
        print("|cffFFD700Difficulté:|r " .. currentMountData.difficulty)
    end
    
    if currentMountData.creatureDisplayId then
        print("|cffFFD700ID Modèle:|r " .. currentMountData.creatureDisplayId)
    end
    
    local isCollected = Core and Core.HasMount(currentMountData.spellId)
    local statusColor = isCollected and "|cff00FF00" or "|cffFF0000"
    local statusText = isCollected and "OUI" or "NON"
    print("|cffFFD700Collecté:|r " .. statusColor .. statusText)
end

function ModelViewer:OpenMountJournal()
    if not currentMountData then
        -- Ouvrir le journal normal
        if CollectionsJournal then
            CollectionsJournal_LoadUI()
            if CollectionsJournal then
                ShowUIPanel(CollectionsJournal)
                CollectionsJournal_SetTab(CollectionsJournal, 1) -- Onglet montures
            end
        end
        return
    end

    -- Essayer d'ouvrir directement sur la monture
    if CollectionsJournal then
        CollectionsJournal_LoadUI()
        if CollectionsJournal then
            ShowUIPanel(CollectionsJournal)
            CollectionsJournal_SetTab(CollectionsJournal, 1)
            
            -- Essayer de trouver la monture dans le journal
            local numMounts = C_MountJournal.GetNumMounts()
            if numMounts then
                for i = 1, numMounts do
                    local mountID, spellID = C_MountJournal.GetMountInfo(i)
                    if spellID == currentMountData.spellId then
                        C_MountJournal.SetSelectedMountIndex(i)
                        break
                    end
                end
            end
        end
    end
end

function ModelViewer:CopyMountLink()
    if not currentMountData or not currentMountData.spellId then
        print("|cffff8800[SmartMounts]|r Aucune monture sélectionnée")
        return
    end

    -- Créer le lien de sort
    local spellLink = GetSpellLink(currentMountData.spellId)
    if spellLink then
        -- Dans WoW, on ne peut pas directement copier dans le presse-papiers
        -- On va afficher le lien pour que le joueur puisse le copier manuellement
        print("|cff00ff00[SmartMounts]|r Lien de la monture: " .. spellLink)
        
        -- Créer une frame temporaire avec le texte sélectionnable
        local copyFrame = CreateFrame("Frame", "SmartMountsCopyFrame", UIParent, "BackdropTemplate")
        copyFrame:SetSize(400, 100)
        copyFrame:SetPoint("CENTER")
        copyFrame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        copyFrame:SetBackdropColor(0, 0, 0, 0.9)
        copyFrame:SetBackdropBorderColor(0.8, 0.8, 0.8, 1)

        local title = copyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        title:SetPoint("TOP", 0, -10)
        title:SetText("Lien de la monture (Ctrl+C pour copier)")
        title:SetTextColor(1, 0.8, 0)

        local editBox = CreateFrame("EditBox", nil, copyFrame, "InputBoxTemplate")
        editBox:SetSize(380, 20)
        editBox:SetPoint("CENTER", 0, -10)
        editBox:SetText(spellLink)
        editBox:SetAutoFocus(true)
        editBox:HighlightText()

        local closeButton = CreateFrame("Button", nil, copyFrame, "GameMenuButtonTemplate")
        closeButton:SetSize(80, 25)
        closeButton:SetPoint("BOTTOM", 0, -35)
        closeButton:SetText("Fermer")
        closeButton:SetScript("OnClick", function()
            copyFrame:Hide()
            copyFrame = nil
        end)

        -- Auto-fermeture après 10 secondes
        C_Timer.After(10, function()
            if copyFrame then
                copyFrame:Hide()
                copyFrame = nil
            end
        end)
    else
        print("|cffff0000[SmartMounts]|r Impossible de créer le lien pour cette monture")
    end
end

function ModelViewer:Hide()
    if modelSection then
        modelSection:Hide()
    end
    currentMountData = nil
    currentMountName = nil
end

function ModelViewer:IsVisible()
    return modelSection and modelSection:IsShown()
end

function ModelViewer:GetCurrentMount()
    return currentMountName, currentMountData
end

return ModelViewer