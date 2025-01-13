# typed: strong

class Product
  sig { params(attribute: Symbol).void }
  def self.has_rich_text(attribute); end

  sig { returns(ActionText::RichText) }
  def description; end

  sig { params(content: T.any(String, ActionText::RichText)).void }
  def description=(content); end
end
