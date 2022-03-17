# frozen_string_literal: true

RSpec.describe ViewComponent::Form::BaseComponent, type: :component do
  let(:object_klass) do
    Class.new do
      include ActiveModel::Model

      attr_accessor :first_name

      validates :first_name, presence: true, length: { minimum: 2 }

      class << self
        def name
          "User"
        end
      end
    end
  end

  let(:object)  { object_klass.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { described_class.new(form, object_name, options) }

  describe "#object_errors?" do
    context "with valid object" do
      let(:object) { object_klass.new(first_name: "John") }

      before { object.validate }

      it { expect(component.object_errors?).to be(false) }
    end

    context "with invalid object" do
      let(:object) { object_klass.new(first_name: "") }

      before { object.validate }

      it { expect(component.object_errors?).to be(true) }
    end

    context "without object" do
      let(:object) { nil }

      it { expect(component.object_errors?).to be(false) }
    end
  end
end
