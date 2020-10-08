class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  def init_emotions
    # IBM Watson NLU Declaration
    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
        apikey: "oJrgtrqPVnwQs40mD_nOKwbPXzBuV96Xv53c4eL_0aE9"
    )
    #IBMWatson::NaturalLanguageUnderstandingV1.new(version: "2018-03-16",iam_apikey: ENV['WATSON_NLU'], url: "https://gateway.watsonplatform.net/natural-language-understanding/api")
    nlu = IBMWatson::NaturalLanguageUnderstandingV1.new(
        version: "2020-08-01",
        authenticator: authenticator
    )
    nlu.service_url = "https://gateway.watsonplatform.net/natural-language-understanding/api"

    response = nlu.analyze(
        text: self.content,
        features: {emotion: {document: true}}
    )
    emotion = response.result["emotion"]["document"]["emotion"]
    self.sadness = emotion["sadness"].to_f
    self.joy = emotion["joy"].to_f
    self.fear = emotion["fear"].to_f
    self.disgust = emotion["disgust"].to_f
    self.anger = emotion["anger"].to_f
  end
end
