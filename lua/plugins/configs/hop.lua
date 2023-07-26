return function()
    local hop = require('hop')
    local opts = { 
        -- keys = 'etovxqpdygfblzhckisuran',
        -- keys = 'jklasdfghuiopqwertnmbzxcv',
        keys = 'jklasdfghuiopqwertnmb',
        term_seq_bias = 0.5,
        case_insensitive = false,
        directional_bias = 1.0,
        reverse_distribution = false,
    }

  hop.setup(opts)
end
