sony_priority_rules = {
  -- Output prioritization (Sink)
  {
    matches = {
      {
        "node.name",
        "equals",
        "bluez_output.AC_80_0A_4F_49_29.1"
      }
    },
    apply_properties = {
      ["priority.driver"] = 2000,  -- Exceeds all standard device priorities
      ["priority.session"] = 2000,
      ["device.profile"] = "a2dp-sink",
      ["api.bluez5.codec"] = "aac"
    }
  },

  -- Input prioritization (Source)
  {
    matches = {
      {
        "node.name",
        "equals",
        "bluez_input.AC_80_0A_4F_49_29"
      }
    },
    apply_properties = {
      ["priority.driver"] = 2000,
      ["priority.session"] = 2000,
      ["device.profile"] = "headset-head-unit"
    }
  },

  -- Device-level profile lock
  {
    matches = {
      {
        "device.name",
        "matches",
        "bluez_card.AC_80_0A_4F_49_29"
      }
    },
    apply_properties = {
      ["bluez5.auto-connect"] = "[a2dp-sink hsp-ag]",
      ["bluez5.codecs"] = "[aac]",
      ["bluez5.msbc-support"] = "false",  -- Disable low-quality voice codec
      ["bluez5.role"] = "client"
    }
  }
}

-- Apply rules only to Bluetooth monitor
for _, rule in ipairs(sony_priority_rules) do
  table.insert(bluez_monitor.rules, rule)
end
