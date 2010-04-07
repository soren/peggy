colors = ["red", "green", "blue", "yellow", "purple", "cyan"]
color_keys = [:]
colors.each( { color_keys[it.charAt(0)]=it } )

println colors.join(",")
color_keys.each( { key, value -> println "$key: $value" } )
