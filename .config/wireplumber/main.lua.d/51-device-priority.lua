rule = {
    matches = {
        { 
            { "node.description", "matches", "WF-1000XM5" },
        }
    },
    apply_properties = {
        ["priority.driver"] = 3000,
        ["priority.session"] = 3000
    }
}

table.insert(alsa_monitor.rules, rule)
table.insert(bluez_monitor.rules, rule)
