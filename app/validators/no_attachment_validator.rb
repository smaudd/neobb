class NoAttachmentsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Check if attachments are present on the reply
    if record.attachments.attached?
      record.errors[attribute] << I18n.t('errors.messages.attachments_not_allowed')
    end
  end
end
