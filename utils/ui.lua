function G.FUNCS.observatory(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
        definition = create_UIBox_observatory()
	})
end

function create_UIBox_observatory()
    -- cards areas
    Observatory.order1 = CardArea(
        0,0,
        4*G.CARD_W,
        1.4*G.CARD_H, 
        {card_limit = 3, type = 'title', highlight_limit = 0}
    )
    for index, value in ipairs(Observatory.config.play_order) do
        for idx, v in ipairs(G.jokers.cards) do
            if value == v.ability.obs_id then
                local card = Card(0,0, G.CARD_W*1.2, G.CARD_H*1.2, v.config.card, v.config.center)
                card.ability = v.ability
                card.no_ui = true
                Observatory.order1:emplace(card)
            end
        end
    end
    Observatory.order1.update = function (self, dt)
        --Check and see if controller is being used
        if G.CONTROLLER.HID.controller and self ~= G.hand then self:unhighlight_all() end
        self.config.temp_limit = math.max(#self.cards, self.config.card_limit)
        self.config.card_count = #self.cards

        for i, v in ipairs(self.cards) do
            Observatory.config.play_order[i] = v.ability.obs_id
        end
    end

    Observatory.order2 = CardArea(
        0,0,
        4*G.CARD_W,
        1.4*G.CARD_H, 
        {card_limit = 3, type = 'title', highlight_limit = 0}
    )
    for index, value in ipairs(Observatory.config.shop_order) do
        for idx, v in ipairs(G.jokers.cards) do
            if value == v.ability.obs_id then
                local card = Card(0,0, G.CARD_W*1.2, G.CARD_H*1.2, v.config.card, v.config.center)
                card.ability = v.ability
                card.no_ui = true
                Observatory.order2:emplace(card)
            end
        end
    end
    Observatory.order2.update = function (self, dt)
        --Check and see if controller is being used
        if G.CONTROLLER.HID.controller and self ~= G.hand then self:unhighlight_all() end
        self.config.temp_limit = math.max(#self.cards, self.config.card_limit)
        self.config.card_count = #self.cards

        for i, v in ipairs(self.cards) do
            Observatory.config.shop_order[i] = v.ability.obs_id
        end
    end

    -- ui
    local t = create_UIBox_generic_options({ back_func = "options_obs", contents = {
        -- pain
        {n=G.UIT.C, config={align = "cm", padding = 0.2}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
                create_toggle({label = "Swap on blind selected", ref_table = Observatory.config, ref_value = "play_swap",
                    callback = function(_set_toggle)
                        Observatory.config.play_swap = _set_toggle
                    end
                })
            }},
            {n=G.UIT.R, config={colour = G.C.BLACK, r = 0.1, align = "cm"}, nodes={
                {n=G.UIT.O, config={object = Observatory.order1, align = "cm"}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
                create_toggle({label = "Swap on shop entered", ref_table = Observatory.config, ref_value = "shop_swap",
                    callback = function(_set_toggle)
                        Observatory.config.shop_swap = _set_toggle
                    end
                })
            }},
            {n=G.UIT.R, config={colour = G.C.BLACK, r = 0.1, align = "cm"}, nodes={
                {n=G.UIT.O, config={object = Observatory.order2, align = "cm"}}
            }}
        }}
    }})
    return t
end

function copy_cards(orig, dest)
    for idx, v in ipairs(orig.cards) do
        local card = Card(0,0, G.CARD_W*1.2, G.CARD_H*1.2, v.config.card, v.config.center)
        card.no_ui = true
        card.ID = v.ID
        dest:emplace(card)
    end
    return dest
end

G.FUNCS.options_obs = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_options(),
    }
end