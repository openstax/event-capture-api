namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'

record :interacted_element_v1 do
  extends :base_web_event
  required :visibility, :string
  required :previous_visibility, :string
end


