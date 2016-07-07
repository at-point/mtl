require 'spec_helper'
require 'action_view'
require 'mtl/rails/avatar_helper'

RSpec.describe Mtl::Rails::AvatarHelper, dom: true do
  subject { ActionView::Base.new }
  before do
    subject.send(:extend, described_class)
  end

  context '#mtl_avatar' do
    it 'renders an <span/> tag with initials and no image, if none provided' do
      expect(subject.mtl_avatar('John Doe'))
        .to eq '<span class="avatar">JD</span>'
    end

    it 'renders an <span/> tag with initials and an image, if an url is provided' do
      expect(subject.mtl_avatar('John Doe', '/image_url.png'))
        .to eq '<span class="avatar"><img alt="John Doe" src="/image_url.png" />JD</span>'
    end
  end

  context '#mtl_avatar_initials' do
    it 'returns the proper initials for a standard name' do
      expect(subject.mtl_avatar_initials('John Doe')).to eq 'JD'
    end

    it 'returns the proper initials for a three words name' do
      expect(subject.mtl_avatar_initials('John Bar Doe')).to eq 'JD'
    end

    it 'returns the proper initials for an email' do
      expect(subject.mtl_avatar_initials('john.doe@example.com')).to eq 'JD'
    end

    it 'returns the proper initials for a long email' do
      expect(subject.mtl_avatar_initials('john-albert.von-doe@example.com')).to eq 'JD'
    end

    it 'returns a single initial for a single name' do
      expect(subject.mtl_avatar_initials('john')).to eq 'J'
    end

    it 'returns a single initial for a single email' do
      expect(subject.mtl_avatar_initials('john@example.com')).to eq 'J'
    end

    it 'returns an empty string when nothins is provided' do
      expect(subject.mtl_avatar_initials('')).to eq ''
    end

    it 'returns an empty string when a malformatted email is provided' do
      expect(subject.mtl_avatar_initials('@example.com')).to eq ''
    end

    it 'returns an empty string when nil is provided' do
      expect(subject.mtl_avatar_initials(nil)).to eq ''
    end
  end

  context '#mtl_avatar_link' do
    it 'renders an <a/> tag with initials and no image, if none provided' do
      expect(subject.mtl_avatar_link('/url', 'John Doe'))
        .to eq '<a class="avatar waves-effect waves-light" href="/url">JD</a>'
    end

    it 'renders an <a/> tag with initials and an image, if an url is provided' do
      expect(subject.mtl_avatar_link('/url', 'John Doe', '/image_url.png'))
        .to eq '<a class="avatar waves-effect waves-light" href="/url"><img alt="John Doe" src="/image_url.png" />JD</a>'
    end
  end
end
