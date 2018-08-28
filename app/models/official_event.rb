class OfficialEvent < Event
    belongs_to :creator,class_name: 'Secretary' #chi lo crea
end