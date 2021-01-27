import 'who_am_i'
import 'ordered_session'
import 'source_uri'

record :base_web_event do
  extends :who_am_i
  extends :ordered_session
  extends :source_uri
end
