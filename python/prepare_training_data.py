def prepare_training_for_curr_year(semnet_now,semnet_future,all_properties_now):
    delta_semnet=semnet_future-semnet_now

    data_0=[]
    data_1=[]
    
    for ii in range(len(delta_semnet)-1):
        for jj in range(ii+1,len(delta_semnet)):
            if semnet_now[ii,jj]==0: # unconnected concept pairs only
                property_vector=[]
                property_vector.append(all_properties_now[0][ii]) # NumsA
                property_vector.append(all_properties_now[0][jj]) # NumsB
                property_vector.append(all_properties_now[1][ii]) # degreeA
                property_vector.append(all_properties_now[1][jj]) # degreeB

                for prop_cc in range(2,len(all_properties_now)):
                    property_vector.append(all_properties_now[prop_cc][ii,jj]) # matrix properties         
                
                if delta_semnet[ii,jj]==0:
                    data_0.append(property_vector) # cases were no connection has been made
                else:
                    data_1.append(property_vector) # cases were a connection has been made
    
    return data_0, data_1


def prepare_training_data(evolving_nets,all_properties,prediction_distance,start_year):
    # If we have evolving SemNets from X to Y,
    # then we can prepare training data for years
    # X+2 (because for properties, we need infos from 2 years before)
    # to
    # Y-prediction_distance (because we have to give the supervision feedback, for which we need SemNet)

    all_data_0=[]
    all_data_1=[]
    for ii in range(len(all_properties)-prediction_distance):
        print('prepare_training_data: Year Now: ',start_year+ii+2,'; Year Future: ',start_year+ii+2+prediction_distance)
        data_0, data_1=prepare_training_for_curr_year(evolving_nets[ii+2],evolving_nets[ii+2+prediction_distance],all_properties[ii])
        all_data_0.append(data_0)
        all_data_1.append(data_1)

    return all_data_0, all_data_1

