provider "aws" {
  region = var.region_name
}
module mysqs_dlq {

  source= "../../mymodules/sqs"
  #for_each                  = var.queue_map
  for_each = {
    for name, queue in var.queue_map : name => queue
    if try(queue.depends_on_dlq,"") == ""
  }
  name                      = each.value.name
  depends_on_dlq            = try(each.value.depends_on_dlq,false)
  visibility_timeout_seconds= length(each.value.visibility_timeout_seconds) > 0 ? each.value.visibility_timeout_seconds:900
  max_message_size          = length(each.value.max_message_size) > 0 ? each.value.max_message_size: 1000
  message_retention_seconds = length(each.value.message_retention_seconds) > 0 ? each.value.message_retention_seconds : 100000
  delay_seconds             = length(each.value.delay_seconds) > 0 ? each.value.delay_seconds : 0
  receive_wait_time_seconds = length(each.value.receive_wait_time_seconds) > 0 ? each.value.receive_wait_time_seconds : 20
  kms_master_key_id         = each.value.kms_master_key_id
  
  tags                      = length(each.value.tags) > 0 ? each.value.tags : {}
  fifo_queue                = try(each.value.fifo_queue,false) == true ? each.value.fifo_queue: false
  content_based_deduplication = try(each.value.content_based_deduplication,false) == true ? each.value.content_based_deduplication: false

  policy            = length(try(each.value.policy,"")) > 0 ? each.value.policy: ""
  #depends_on = [each]
}


module mysqs {

  source= "../../mymodules/sqs"
  #for_each                  = var.queue_map
  for_each = {
    for name, queue in var.queue_map : name => queue
    if try(queue.depends_on_dlq,"") == true
  }
  name                      = each.value.name
  visibility_timeout_seconds= length(each.value.visibility_timeout_seconds) > 0 ? each.value.visibility_timeout_seconds:900
  max_message_size          = length(each.value.max_message_size) > 0 ? each.value.max_message_size: 1000
  message_retention_seconds = length(each.value.message_retention_seconds) > 0 ? each.value.message_retention_seconds : 100000
  delay_seconds             = length(each.value.delay_seconds) > 0 ? each.value.delay_seconds : 0
  receive_wait_time_seconds = length(each.value.receive_wait_time_seconds) > 0 ? each.value.receive_wait_time_seconds : 20
  kms_master_key_id         = each.value.kms_master_key_id
  dlq_name                  = each.value.dlq_name
  depends_on_dlq            = try(each.value.depends_on_dlq,true)
  dlq_arn                   = module.mysqs_dlq[each.value.dlq_name].sqs_queue_arn[0]

  tags                      = length(each.value.tags) > 0 ? each.value.tags : {}
  fifo_queue                = try(each.value.fifo_queue,false) == true ? each.value.fifo_queue: false
  content_based_deduplication = try(each.value.content_based_deduplication,false) == true ? each.value.content_based_deduplication: false

  policy            = length(try(each.value.policy,"")) > 0 ? each.value.policy: ""
  
}