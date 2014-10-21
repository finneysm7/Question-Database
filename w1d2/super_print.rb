def super_print (string, options = {})
  defaults = {
              :times => 1,
              :upcase => false,
              :reverse => false
              }            
  options = defaults.merge(options)
  
  string *= options[:times]
  string.upcase! if options[:upcase] 
  string.reverse! if options[:reverse]
  
  string
  
end

