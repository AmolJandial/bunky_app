class Database {
  Map<String, Map<String, dynamic>> filteredSubjects(
      String semester, String course) {
    //{Subject:{Subect:   , teacherName: ........}
    if (course == 'cse') {
      switch (semester) {
        case '1':
          return {
            'Quantum Physics': {
              'subjectName': 'Quantum Physics',
              'subjectTeacher': 'ABCD',
              'attended': 0,
              'missed': 0,
              'totalAttended': 0,
              'subjectDate': ['Mon', 'Tue', 'Wed']
            },
            'Calculus': {
              'subjectName': 'Calculus',
              'subjectTeacher': 'Minto',
              'attended': 0,
              'missed': 0,
              'totalAttended': 0,
              'subjectDate': ['Mon', 'Tue', 'Wed']
            },
            'Microprocessor': {
              'subjectName': 'Microprocessor',
              'subjectTeacher': 'Sukhwinder',
              'attended': 0,
              'missed': 0,
              'totalAttended': 0,
              'subjectDate': ['Thu', 'Fri', 'Sat']
            }
          };
          break;
        default:
      }
    }

    return null;
  }
}
