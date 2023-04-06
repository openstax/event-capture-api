namespace 'org.openstax.ec'

import 'types/uuid'
import 'types/date_time'
import 'types/base_web_event'
import 'types/source_metadata'

record :accessed_studyguide_v1 do
  extends :base_web_event
  required :page_id, :string
  required :book_id, :string
  required :occurred_at, :timestamp
  optional :source_metadata, :source_metadata
end
