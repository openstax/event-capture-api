if !File.exists?(File.join(__dir__, '../secrets.yml'))
  raise "'config/secrets.yml' is missing; run `rake setup` to create it"
  exit
end

