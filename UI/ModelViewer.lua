local addonName, addonTable = ...

-- Créer le module UI si il n'existe pas
addonTable.UI = addonTable.UI or {}

-- Références aux modules
local Core = addonTable.Core
local Constants = addonTable.Utils and addonTable.Utils.Constants

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
    modelTitle:SetText(Constants and Constants.MESSAGES.LABELS.MOUNT_PREVIEW or "Aperçu Monture")
    modelTitle:SetTextColor(1, 0.8, 0)

    -- Nom de la monture affichée
    modelMountName = modelSection:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    modelMountName:SetPoint("TOP", modelTitle, "BOTTOM", 0, -10)
    modelMountName:SetText(Constants and Constants.MESSAGES.LABELS.HOVER_TO_DISPLAY or "Survolez une monture pour l'afficher")
    modelMountName:SetTextColor(0.7, 0.7, 0.7)

    -- Container pour le modèle 3D
    local modelContainer = CreateFrame("Frame", nil, modelSection)
    modelContainer:SetSize(340, 300) -- Réduit la hauteur pour faire de la place
    modelContainer:SetPoint("TOP", modelMountName, "BOTTOM", 0, -20)

    -- Modèle 3D avec contrôles de rotation par clic + drag
    model = CreateFrame("PlayerModel", nil, modelContainer)
    model:SetSize(340, 300) -- Même taille que le container
    model:SetPoint("TOPLEFT")
    model:EnableMouse(true)
    
    -- Variables pour la rotation par drag
    local isDragging = false
    local lastMouseX = 0
    
    model:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            isDragging = true
            local cursorX = GetCursorPosition()
            lastMouseX = cursorX
            self:SetScript("OnUpdate", function(self)
                if isDragging then
                    local cursorX = GetCursorPosition()
                    local deltaX = (cursorX - lastMouseX) * 0.01
                    local currentRotation = self.currentRotation or 0
                    currentRotation = currentRotation + deltaX
                    if currentRotation > 6.28 then currentRotation = currentRotation - 6.28 end
                    if currentRotation < 0 then currentRotation = currentRotation + 6.28 end
                    self:SetRotation(currentRotation)
                    self.currentRotation = currentRotation
                    lastMouseX = cursorX
                end
            end)
        end
    end)
    
    model:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            isDragging = false
            self:SetScript("OnUpdate", nil)
        end
    end)
    
    -- Stocker la référence du container
    modelSection.modelContainer = modelContainer

    -- Instructions de contrôle
    local instructions = modelSection:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    instructions:SetPoint("TOP", modelContainer, "BOTTOM", 0, -5)
    instructions:SetText(Constants and Constants.MESSAGES.LABELS.MOUSE_DRAG_INSTRUCTION or "Clic gauche + glisser pour faire tourner")
    instructions:SetTextColor(0.7, 0.7, 0.7)

    -- Créer le cadre des détails après les instructions
    local detailsFrame = self:CreateDetailsFrame(modelSection)
    detailsFrame:SetPoint("TOP", instructions, "BOTTOM", 0, -10)
    
    -- Boutons d'action placés tout en bas de la frame
    self:CreateActionButtons(modelSection, detailsFrame)

    -- Cacher la section par défaut
    modelSection:Hide()

    return modelSection
end

function ModelViewer:CreateDetailsFrame(parent)
    local detailsFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    detailsFrame:SetSize(340, 140) -- Augmenté légèrement pour plus d'espace
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

function ModelViewer:CreateActionButtons(parent, anchorFrame)
    local buttonContainer = CreateFrame("Frame", nil, parent)
    buttonContainer:SetSize(340, 35)
    -- Positionner les boutons tout en bas de la frame principale
    buttonContainer:SetPoint("BOTTOM", parent, "BOTTOM", 0, 15)

    -- Bouton d'information détaillée
    local infoButton = CreateFrame("Button", nil, buttonContainer, "GameMenuButtonTemplate")
    infoButton:SetSize(160, 25)
    infoButton:SetPoint("LEFT", 10, 0)
    infoButton:SetText("Afficher détails")
    infoButton:SetScript("OnClick", function(self)
        ModelViewer:ShowMountDetails()
    end)

    -- Bouton pour invoquer la monture (si collectée)
    local summonButton = CreateFrame("Button", nil, buttonContainer, "GameMenuButtonTemplate")
    summonButton:SetSize(160, 25)
    summonButton:SetPoint("RIGHT", -10, 0)
    summonButton:SetText("Invoquer")
    summonButton:SetScript("OnClick", function(self)
        ModelViewer:SummonMount()
    end)

    -- Stocker les références
    buttonContainer.infoButton = infoButton
    buttonContainer.summonButton = summonButton
    
    parent.actionButtons = buttonContainer
    
    return buttonContainer
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
        local nameColor = Constants and Constants:GetCollectionStatusColor(isCollected) or (isCollected and "|cff4CAF50" or "|cffFFFFFF")
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
    
    -- Mettre à jour les boutons
    self:UpdateButtons(mountData)
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
            
            -- Status de collection
            local isCollected = Core and Core.HasMount(mountData.spellId)
            local statusColor = MountConstants and MountConstants.COLORS.SUCCESS or "|cff00FF00"
            local missingColor = MountConstants and MountConstants.COLORS.WARNING or "|cffFF5722"
            local finalStatusColor = isCollected and statusColor or missingColor
            local statusText = isCollected and "COLLECTÉ" or "MANQUANT"
            local infoColor = MountConstants and MountConstants.COLORS.INFO or "|cffFFD700"
            table.insert(infoLines, infoColor .. "Statut:|r " .. finalStatusColor .. statusText)
            
            child.infoText:SetText(table.concat(infoLines, "\n"))
            break
        end
    end
end

function ModelViewer:UpdateButtons(mountData)
    if not modelSection or not modelSection.actionButtons then
        return
    end
    
    local isCollected = Core and Core.HasMount(mountData.spellId)
    local summonButton = modelSection.actionButtons.summonButton
    
    if summonButton then
        if isCollected then
            summonButton:Enable()
            summonButton:SetText("Invoquer")
        else
            summonButton:Disable()
            summonButton:SetText("Non obtenue")
        end
    end
end

function ModelViewer:ShowMountDetails()
    if not currentMountData or not currentMountName then
        local errorMsg = Constants and Constants:GetErrorMessage("NO_MOUNT_SELECTED") or "|cffff8800[SmartMounts]|r Aucune monture sélectionnée"
        print(errorMsg)
        return
    end

    print("|cff00ff00=== Détails de la monture ===|r")
    local details = Constants and Constants.MESSAGES.DETAILS or {}
    
    print((details.NAME or "|cffFFD700Nom:|r") .. " " .. (currentMountName or "N/A"))
    print((details.SPELL_ID or "|cffFFD700ID Sort:|r") .. " " .. (currentMountData.spellId or "N/A"))
    print((details.CATEGORY or "|cffFFD700Catégorie:|r") .. " " .. (currentMountData.category or "N/A"))
    print((details.EXPANSION or "|cffFFD700Expansion:|r") .. " " .. (currentMountData.expansion or "N/A"))
    print((details.SOURCE or "|cffFFD700Source:|r") .. " " .. (currentMountData.source or "N/A"))
    
    if currentMountData.boss then
        print((details.BOSS or "|cffFFD700Boss:|r") .. " " .. currentMountData.boss)
    end
    
    if currentMountData.dropChance then
        print((details.DROP_RATE or "|cffFFD700Taux de drop:|r") .. " " .. currentMountData.dropChance)
    end
    
    if currentMountData.difficulty then
        print((details.DIFFICULTY or "|cffFFD700Difficulté:|r") .. " " .. currentMountData.difficulty)
    end
    
    if currentMountData.creatureDisplayId then
        print((details.MODEL_ID or "|cffFFD700ID Modèle:|r") .. " " .. currentMountData.creatureDisplayId)
    end
    
    local isCollected = Core and Core.HasMount(currentMountData.spellId)
    local statusColor = Constants and (isCollected and Constants.COLORS.SUCCESS or Constants.COLORS.ERROR) or (isCollected and "|cff00FF00" or "|cffFF0000")
    local statusText = isCollected and "OUI" or "NON"
    print((details.COLLECTED_STATUS or "|cffFFD700Collecté:|r") .. " " .. statusColor .. statusText .. "|r")
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

function ModelViewer:SummonMount()
    if not currentMountData or not currentMountData.spellId then
        print("|cffff8800[SmartMounts]|r Aucune monture sélectionnée")
        return
    end
    
    local isCollected = Core and Core.HasMount(currentMountData.spellId)
    if not isCollected then
        print("|cffff0000[SmartMounts]|r Vous ne possédez pas cette monture")
        return
    end
    
    -- Invoquer la monture
    local spellName = GetSpellInfo(currentMountData.spellId)
    if spellName then
        CastSpellByName(spellName)
        print("|cff00ff00[SmartMounts]|r Invocation de " .. (currentMountName or spellName))
    else
        print("|cffff0000[SmartMounts]|r Impossible d'invoquer cette monture")
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