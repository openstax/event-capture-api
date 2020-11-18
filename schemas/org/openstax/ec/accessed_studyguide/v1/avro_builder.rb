namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/device'
import 'types/ordered_session'

record :accessed_studyguide_v1 do
  extends :device
  extends :ordered_session
  required :user_uuid, :uuid
  required :page_id, :string
  required :book_id, :string
  required :occurred_at, :timestamp
end
