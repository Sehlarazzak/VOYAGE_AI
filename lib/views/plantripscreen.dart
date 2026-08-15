import 'package:first_project/views/loadingscreen.dart';
import'package:flutter/material.dart';
import 'package:first_project/widgets/custom_interestcontainer.dart';
import 'package:first_project/widgets/custom_textfield.dart';
import 'package:first_project/widgets/custom_destinationbuttons.dart';
import 'package:first_project/widgets/custom_travelstyle.dart';

class Plantripscreen extends StatefulWidget{
  const Plantripscreen({super.key});

  @override
  State<Plantripscreen> createState() => _PlantripscreenState();

}

class _PlantripscreenState extends State<Plantripscreen> {
  
  
  TextEditingController destinationcontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  int days = 0;
  int travellers = 0;
  List<String> selectedInterests = [];
  String? selectedTravelStyle;

  @override
  void initState() {
    super.initState();
  destinationcontroller.addListener(() {
    setState(() {});
  });

  budgetcontroller.addListener(() {
    setState(() {});
  });
  }

  @override
  void dispose() {
    destinationcontroller.dispose();
    budgetcontroller.dispose();
    super.dispose();
  }

  void selectTravelStyle(String style) {
    setState(() {
      selectedTravelStyle = style;
    });
  }

  void toggleInterests(String interest) {
    setState(() {
      if(selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      }
      else {
        selectedInterests.add(interest);
      }
    });
  }

  bool get isFormComplete {
    return destinationcontroller.text.isNotEmpty &&
    budgetcontroller.text.isNotEmpty &&
    days > 0 &&
    travellers > 0 &&
    selectedInterests.isNotEmpty &&
    selectedTravelStyle != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () { Navigator.pop(context);
          }, 
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF0F1C35),
          ),
          ),
          title: const Text(
          "Plan Your Trip",
          style: TextStyle(
            color: Color(0xFF0F1C35),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
      ), 
      ),

      body: SafeArea(
        child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFEEF4FF),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
            
            Text(
              'DESTINATION',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            CustomTextfield(
              controller: destinationcontroller,
             hinttext: 'e.g. Hunza Valley, Lahore, Swat',
            prefixicon: Icons.location_city_outlined,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                                  
                          CustomDestinationbuttons(title: 'Hunza', onTap: () {
                            destinationcontroller.text = 'hunza';
                          }),
                                  
                          CustomDestinationbuttons(title: 'Lahore', onTap: () {
                            destinationcontroller.text = 'lahore';
                          }),
                                  
                          CustomDestinationbuttons(title: 'Skardu', onTap: () {
                            destinationcontroller.text = 'skardu';
                          }),
                                  
                          CustomDestinationbuttons(title: 'Dir', onTap: () {
                            destinationcontroller.text = 'dir';
                          }),
                                  
              ],
            ),

            const SizedBox(height: 30),

            Text(
              'TOTAL BUDGET (PKR)',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            CustomTextfield(
              controller: budgetcontroller, 
              hinttext: '30,000', 
              prefixicon: Icons.currency_rupee_outlined,
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F7FF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFE7ECF5),
                         ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                               size: 16,
                               color: Color(0xFF1E6AE1),
                              ),
                              SizedBox(width: 6),
                              Text('DAYS',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                               ),
                              ),
                            ],
                          ),
                          const Spacer(),
                      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  
                                  if(days > 1) {
                                    setState(() {
                                      days--;
                                    });
                                  }
                                },

                                child: Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE9EDF5),
                                    shape: BoxShape.circle,
                                  ),

                                  child: const Icon(Icons.remove,
                                  color: Color(0xFF6B7280),
                                  ),
                                ),
                              ),

                              Text(
                                '$days',
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F1C35),
                                ),

                              ),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    days++;
                                  });
                                },

                                child: Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E6AE1),
                                    shape: BoxShape.circle,
                                  ),

                                  child: Icon(Icons.add,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                      
                      
                            ],
                          ),
                        ],
                      ),

                      
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F7FF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFE7ECF5),
                         ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.people_outline,
                               size: 16,
                               color: Color(0xFF1E6AE1),
                              ),
                              SizedBox(width: 6),
                              Text('TRAVELLERS',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                               ),
                              ),
                            ],
                          ),
                          const Spacer(),
                      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  
                                  if(travellers > 1) {
                                    setState(() {
                                      travellers--;
                                    });
                                  }
                                },

                                child: Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE9EDF5),
                                    shape: BoxShape.circle,
                                  ),

                                  child: const Icon(Icons.remove,
                                  color: Color(0xFF6B7280),
                                  ),
                                ),
                              ),

                              Text(
                                '$travellers',
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F1C35),
                                ),

                              ),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    travellers++;
                                  });
                                },

                                child: Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E6AE1),
                                    shape: BoxShape.circle,
                                  ),

                                  child: Icon(Icons.add,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                      
                      
                            ],
                          ),
                        ],
                      ),

                      
                    ),
                  ),



                ],
              ),

              const SizedBox(height: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('INTERESTS',
                  style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
                  ),

                  SizedBox(width: 6),

                  Text('-select all that apply',
                  style: TextStyle(
                    color: Color(0xFF1E6AE1),
                    fontSize: 10,
                  ),
                  ),

                ],
              ),

              
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(child: CustomInterestcontainer(
                        title: 'Nature', 
                        icon: Icons.landscape_outlined, 
                        isSelected: selectedInterests.contains('Nature'), 
                        onTap: () => toggleInterests('Nature'),
                        ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(child: CustomInterestcontainer(
                          title: 'Adventure', 
                          icon: Icons.explore_outlined, 
                          isSelected: selectedInterests.contains('Adventure'),
                          onTap: () => toggleInterests('Adventure'),
                          ),
                          ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  
                  Row(
                    children: [
                      Expanded(child: CustomInterestcontainer(
                        title: 'Food', 
                        icon: Icons.restaurant_outlined, 
                        isSelected: selectedInterests.contains('Food'), 
                        onTap: () => toggleInterests('Food'),
                        ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(child: CustomInterestcontainer(
                          title: 'Photography', 
                          icon: Icons.camera_alt_outlined, 
                          isSelected: selectedInterests.contains('Photography'),
                          onTap: () => toggleInterests('Photography'),
                          ),
                          ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  
                  Row(
                    children: [
                      Expanded(child: CustomInterestcontainer(
                        title: 'History', 
                        icon: Icons.menu_book_outlined, 
                        isSelected: selectedInterests.contains('History'), 
                        onTap: () => toggleInterests('History'),
                        ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(child: CustomInterestcontainer(
                          title: 'Luxury', 
                          icon: Icons.workspace_premium_outlined, 
                          isSelected: selectedInterests.contains('Luxury'),
                          onTap: () => toggleInterests('Luxury'),
                          ),
                          ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  
                  Row(
                    children: [
                      Expanded(child: CustomInterestcontainer(
                        title: 'Shopping', 
                        icon: Icons.shopping_bag_outlined, 
                        isSelected: selectedInterests.contains('Shopping'), 
                        onTap: () => toggleInterests('Shopping'),
                        ),
                        ),

                        const Spacer(),

                      
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'TRAVEL STYLE',
                    style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTravelstyle(
                          title: 'Budget', 
                          price: 'PKR 5k-15k/day', 
                          icon: Icons.star_border, 
                          iconColor: Colors.green, 
                          isSelected: selectedTravelStyle == 'Budget', 
                          onTap:() => selectTravelStyle('Budget'),
                           ),
                      ),

                         Expanded(
                           child: CustomTravelstyle(
                                                   title: 'Moderate', 
                                                   price: 'PKR 15k-40k/day', 
                                                   icon: Icons.star_border, 
                                                   iconColor: Colors.blue, 
                                                   isSelected: selectedTravelStyle == 'Moderate', 
                                                   onTap:() => selectTravelStyle('Moderate'),
                           ),
                         ),

                         Expanded(
                           child: CustomTravelstyle(
                                                   title: 'Luxury', 
                                                   price: 'PKR 40k+/day', 
                                                   icon: Icons.star_border, 
                                                   iconColor: Colors.purple, 
                                                   isSelected: selectedTravelStyle == 'Luxury', 
                                                   onTap:() => selectTravelStyle('Luxury'),
                           ),
                         ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  GestureDetector(
                    onTap: isFormComplete ? () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoadingScreen(
        destination: destinationcontroller.text,
        budget: budgetcontroller.text,
        days: days,
        travellers: travellers,
        interests: selectedInterests,
        travelStyle: selectedTravelStyle!,
      ),
    ),
  );

  if (result == true) {
    // We will handle the result here
  }
} : null,

                    child: Container(
                      width: double.infinity,
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isFormComplete? const Color(0xFF1E6AE1) : const Color(0xFFF0F3F8),
                        borderRadius: BorderRadius.circular(22),
                      ),

                      child: Row(
                        children: [
                          Icon(Icons.auto_awesome,
                          size: 27,
                          color: isFormComplete? Colors.white : const Color(0xFF9AAAC2),
                          ),

                          const SizedBox(width: 12),

                          Expanded(child: Text(
                            'Generate AI Itinerary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isFormComplete? Colors.white : const Color(0xFF9AAAC2),
                            ),
                          ),
                          ),

                          Icon(Icons.arrow_forward_ios,
                          size: 20,
                          color: isFormComplete? Colors.white : const Color(0xFF9AAAC2),
                          ),
                        ],
                      ),
                    ),
                  ),

            ],
          ),

        ),
        
      ),
      ),
    );
  }
}